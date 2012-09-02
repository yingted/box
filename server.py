#!/usr/bin/python
from wsgiref.simple_server import make_server,demo_app
from cgi import FieldStorage
from threading import Timer
from subprocess import check_output,call
from os.path import normpath,exists
from urlparse import urlparse,parse_qs
from subprocess import Popen,PIPE
from os import listdir
import re
CT_PLAIN=("Content-type","text/plain;charset=UTF-8")
binputb=re.compile("\\binput\\b")
bdosb=re.compile("\\bdos\\b")
slashall=re.compile("/[^/]*$")
stuff=("-e","modify","-e","move","-e","create","-e","delete","-e","unmount","-e","close")
def problem(x):
	return slashall.sub("/problem.txt",x)
def update(nodelay=False):
	global flist
	nodelay=nodelay or call(("inotifywait","-qo/dev/null","-rt30","rootfs/data")+stuff)==2
	files=sorted([x[11:]for x in check_output(("find","rootfs/data","-name","*input*","-print0")).split("\0")if binputb.search(x)and not bdosb.search(x)],reverse=True)
	flist=("\n".join(files),sorted(set(map(problem,files))),{},files)
	print"found %d files"%len(files)
	t=Timer(int(not nodelay),update)
	t.setDaemon(True)
	t.start()#wait 1 sec for modification, ratelimit
update(True)
def read(path):
	h=flist[2]
	if path not in h:
		f=open(path,"r")
		h[path]=f.read()
		f.close()
	return h[path]
def handler(env,respond):
	base=[]
	if"HTTP_ORIGIN"in env:
		host=env["HTTP_ORIGIN"]
		if host in("http://localhost","http://localhost:8080"):
			base=[("Access-Control-Allow-Origin",host)]
	rc="200 OK"
	def good(msg):
		respond(rc,base+[CT_PLAIN]+[("Content-length",str(len(msg)))])
		return(msg,)
	def err(msg):
		respond(msg,base+[])
		return()
	path=env.get("PATH_INFO","/")
	user=env["REMOTE_ADDR"]
	if path=="/":
		return good(flist[0])
	elif path in flist[1]:
		return good(read("rootfs/data"+path))
	elif path=="/submit":
		inlen=int(env.get("CONTENT_LENGTH",-1))
		if inlen<0:
			return err("411 Length Required")
		if inlen>64*1024:
			print inlen,"too large"
			return err("413 Request Entity Too Large")
		infile=parse_qs(env.get("QUERY_STRING","")).get("input")
		if not infile or type(infile)!=list or len(infile)!=1:
			return err("400 Bad Request")
		infile=infile[0]
		if infile not in flist[3]:
			return err("404 Not Found")
		rc,msg=Popen(("./nq.sh",user,infile),stdin=PIPE,stdout=PIPE).communicate(env["wsgi.input"].read(inlen))[0].split("\n")
		return good(msg)
	elif path=="/code":
		return good('\n'.join([user]+([x for x in listdir("code/"+user)if x!="lock"]if exists("code/"+user)else[])))
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
	make_server("",8000,handler).serve_forever()
