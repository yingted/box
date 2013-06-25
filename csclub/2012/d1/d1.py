#!/usr/bin/python
inp=file("DATA1.txt")
out=file("OUT1.txt","w")
for n in map(int,inp):
	for x in xrange(1,n):
		out.write("*"*x+'\n')
	for x in xrange(n,0,-1):
		out.write("*"*x+'\n')
