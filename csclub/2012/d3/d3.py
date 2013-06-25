#!/usr/bin/python
inp=file("DATA3.txt")
out=file("OUT3.txt","w")
for _ in xrange(5):
	n=int(inp.readline())
	d={}
	q=[]
	for _ in xrange(n):
		x,y=inp.readline().split()
		if y in d:
			q.append(x)
		else:
			d[y]=x
	out.write((" ".join(q)if len(q)else"SPOOKY")+"\n')
