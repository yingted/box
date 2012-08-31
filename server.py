#!/usr/bin/python
from wsgiref.simple_server import make_server,demo_app
from cgi import FieldStorage
from threading import Timer
from subprocess import check_output
from os.path import getmtime
from urlparse import urlparse,parse_qs
from subprocess import Popen,PIPE
import re
CT_PLAIN=("Content-type","text/plain;charset=UTF-8")
binputb=re.compile("\\binput\\b")
bdosb=re.compile("\\bdos\\b")
slashall=re.compile("/[^/]*$")
def problem(x):
	return slashall.sub("/problem.txt",x)
def update():
	global flist
	files=sorted([x[11:]for x in check_output(("find","rootfs/data","-name","*input*","-print0")).split("\0")if binputb.search(x)and not bdosb.search(x)],reverse=True)
	flist=("\n".join(files),sorted(set(map(problem,files))),{},files)
	print"found %d files"%len(files)
	Timer(300,update).start()
update()
def read(path):
	h=flist[2]
	if path not in h:
		f=open(path,"r")
		h[path]=f.read()
		f.close()
	return h[path]
def handler(env,respond):
	rc="200 OK"
	def good(msg):
		respond(rc,[CT_PLAIN]+[("Content-length",str(len(msg)))])
		return(msg,)
	def err(msg):
		respond(msg,[])
		return()
	path=env.get("PATH_INFO","/")
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
		rc,msg=Popen(("./nq.sh",env["REMOTE_ADDR"],infile),stdin=PIPE,stdout=PIPE).communicate(env["wsgi.input"].read(inlen))[0].split("\n")
		return good(msg)
	else:
		return err("404 Not Found")
make_server('',8000,handler).serve_forever()
