#!/usr/bin/python2 -S
from wsgiref.simple_server import make_server#,demo_app
from cgi import FieldStorage
from threading import Timer,Event
from subprocess import check_output,call
from os.path import normpath,exists
from urlparse import urlparse,parse_qs
from subprocess import Popen,PIPE
from os import listdir
from shlex import split
from traceback import print_exc
from collections import defaultdict
import re
CT_PLAIN=("Content-type","text/plain;charset=UTF-8")
binputb=re.compile(r"\binput\b")
bdosb=re.compile("\bdos\b")
slashall=re.compile("/[^/]*$")
stuff=("-e","modify","-e","move","-e","create","-e","delete","-e","unmount","-e","close_write")
def problem(x):
	return slashall.sub("/problem.txt",x)
def update(path,cb,nodelay=False):
	nodelay=nodelay or call(("inotifywait","-qo/dev/null","-rt30",path)+stuff)==2
	try:
		cb()
	except:
		print"="*79+"{"
		print_exc()
		print"}"+"="*79
	t=Timer(int(not nodelay),update,(path,cb))
	t.setDaemon(True)
	t.start()#wait 1 sec for modification, ratelimit
def watch(path):
	def fun(cb):
		update(path,cb,True)
		return cb
	return fun
def readConf(path):
	conf={}
	for pref in split(open(path).read(),True):
		m=pref.split("=",1)
		if len(m)==2:
			conf[m[0]]=m[1]
	return conf
onprefchange=defaultdict(list)
conf={}
@watch("config")
def loadConfig():
	global conf
	oldconf=conf
	conf=readConf("config")
	for k in set(oldconf.keys()+conf.keys()):
		if k not in oldconf or k not in conf or oldconf[k]!=conf[k]:
			for cb in onprefchange[k]:
				cb()
@watch(conf["user_conf"])
def loadUsers():
	global users
	users=readConf("users")
@watch(conf["data_dir"])
def flistcb():
	global flist
	allfiles=sorted([x[len(conf["data_dir"]):]for x in check_output(("find","-L",conf["data_dir"],"-type","f","-name","*input*","-perm","-4","-print0")).split("\0")if binputb.search(x)and not bdosb.search(x)],reverse=True)
	fileset=set(allfiles)
	files=[x for x in filter(bool,conf.get("problem_pref","").split(","))if x in fileset]
	fileset=set(files)
	files+=[x for x in allfiles if x not in fileset]
	flist=("\n".join(files),sorted(set(map(problem,files))),{},files)
	print"found %d files"%len(files)
onprefchange["problem_pref"].append(flistcb)
def read(path):
	h=flist[2]
	if path not in h:
		f=open(path,"r")
		h[path]=f.read()
		f.close()
	return h[path]
scores=None
scoreupdate=Event()
@watch("code")
def scorescb():
	global scores,scoreupdate
	old=scores
	score_sub_s=[]
	for x in check_output(("find","code","-mindepth","3","-name","solution.*","-type","f","-print0")).split("\0")[:-1]:
		try:
			score_sub_s.append((map(int,read(x[:x.rindex("/")]+"/score").split("\n")[-2].split(" ")),x.split("/")))
		except:
			pass
	ip_in_score_time_s=dict([((p[1],read("/".join(p[:3])+"/in").rstrip("\n")),(s,int(p[2])))for(s,p)in sorted(score_sub_s,reverse=True)]).items()
	ip_in_score_time_s.sort(key=lambda e:e[0][0])#for compare
	ip_in_score_time_s.sort(key=lambda e:e[1][1])
	ip_in_score_time_s.sort(key=lambda e:e[1][0],reverse=True)
	ip_in_score_time_s.sort(key=lambda e:e[0][1],reverse=True)
	last=line=None
	scores=[]
	for((ip,inp),(s,t))in ip_in_score_time_s:
		if inp!=last:
			last=inp
			scores.append("\n"+inp)
		scores.append("\t")
		scores.append((ip," ".join(map(str,s))+" "+str(t)))
	if scores:
		scores[0]=scores[0][1:]
	if scores!=old:
		print"updated %d scores"%len(ip_in_score_time_s)
		scoreupdate.set()
		scoreupdate.clear()
def application(env,respond):
	base=[]
	if"HTTP_ORIGIN"in env:
		host=env["HTTP_ORIGIN"]
		def stripport(host):
			return host[0:host.rindex(":")]if ":"in host else host
		if stripport(host).endswith(stripport(env.get("HTTP_HOST",""))):
			base=[("Access-Control-Allow-Origin",host)]
	rc="200 OK"
	def good(msg):
		respond(rc,base+[CT_PLAIN]+[("Content-length",str(len(msg)))])
		return(msg,)
	def err(msg):
		respond(msg,base+[])
		return()
	path=env.get("PATH_INFO","/")
	parts=path.split("/",3)
	user=pw=None
	if len(parts)==4:
		if users.get(parts[1],None)==parts[2]:
			user,pw=parts[1:3]
			path="/".join(parts[:1]+parts[3:])
	if path=="/":
		return good(flist[0])
	elif path in flist[1]:
		try:
			return good(read(conf["data_dir"]+path))
		except IOError:
			pass#404
	elif path=="/scores":
		t=float(parse_qs(env.get("QUERY_STRING","")).get("timeout",[0])[0])
		if t:#optimize
			scoreupdate.wait(None if t<0 else t)
		return good("".join([x if type(x)==str else x[1]if user!=x[0]else"*"+x[1]for x in scores]))
	elif user is None:
		return err("403 Forbidden")
	elif path=="/submit":
		get=parse_qs(env.get("QUERY_STRING",""))
		inlen=int(env.get("CONTENT_LENGTH",-1))
		if inlen<0:
			return err("411 Length Required")
		if inlen>64*1024:
			print inlen,"too large"
			return err("413 Request Entity Too Large")
		for param in"input","lang":
			if len(get.get("input",[]))!=1:
				return err("400 Bad Request")
		infile=get["input"][0]
		lang=get["lang"][0]
		if infile not in flist[3]or lang not in("cpp","cpp11","java","js","lua","py2","py3","t"):
			return err("404 Not Found")
		rc,msg=Popen(("./nq.sh",user,infile,lang),stdin=PIPE,stdout=PIPE).communicate(env["wsgi.input"].read(inlen))[0].split("\n")
		return good(msg)
	elif path=="/code":
		return good('\n'.join([user]+([next(x+sol[8:]for sol in listdir("code/"+user+"/"+x)if sol.startswith("solution."))for x in listdir("code/"+user)if x!="lock"]if exists("code/"+user)else[])))
	elif path.startswith("/code/")and path[6:].startswith(user+"/"):
		if path!=normpath(path):
			return err("400 Bad Request")
		path=path[1:]
		req=path[6+len(user):].split("/")
		if len(req)!=2:
			return err("400 Bad Request")
		if req[1]in("out","score"):
			dirpath=path[:-len(req[1])]
			scorepath=dirpath+"score"
			while not exists(scorepath):
				if call(("inotifywait","-qo/dev/null","-t1","-e","create",dirpath))==1:
					return err("404 Not Found")
			return good(read(path))
		if exists(path):
			return good(read(path))
	return err("404 Not Found")
if __name__=="__main__":
	make_server("",8000,application).serve_forever()
