#!/usr/bin/python
import re
inp=file("DATA4.txt")
out=file("OUT4.txt","w")
def count(s):
	if s[0]=='(':
		s,t,d,z=count(s[1:])
		s,t2,d2,z2=count(s[1:])
		return s[1:],t+t2,d+d2+4,max(z,z2)+1
	d=re.match("^[0-9]*",s).end()
	return s[d:],int(s[:d]),0,0
for x in inp:
	x=count(x)
	out.write(str(x[2]-x[3])+" "+str(x[1])+"\n")
