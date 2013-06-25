from random import *
from string import *
from itertools import *
from sys import *
from cStringIO import *
chars=letters+punctuation
down=1#0
for _ in xrange(100/down):
	n=randint(1,200/down)
	nw=randint(1,255/down)
	m=randint(1,n)
	mw=randint(1,nw)
	k=int(expovariate(1.5))+1
	out=[(n,StringIO()),(m,StringIO())]
	def get(n,nw):
		for w,s in islice(islice(cycle((((nw+1)/2,""),(nw/2," "))),randint(0,int(n>1 or nw>1)),n+1),n):
			yield s,[choice(chars)for _ in xrange(w)]
	def fmt(s,l):
		return s+" ".join(l)
	a=[]
	for x in get(n,nw):
		print>>out[0][1],fmt(*x)
		a.append(x)
	if randint(0,2):
		st=randint(0,nw-mw)
		if randint(0,1):
			l=choice(a)[1]
			i,v=choice(list(enumerate(l)))
			l[i]=choice(chars.translate(None,v))
		for x in islice(islice(a,randint(0,n-m),n),m):
			print>>out[1][1],fmt(*x)[st:][:mw].rstrip(" ")
	else:
		for x in starmap(fmt,get(m,mw)):
			print>>out[1][1],x
	if not randint(0,9):
		out.reverse()
	print out[0][0]*k,out[1][0]
	stdout.write(out[0][1].getvalue()*k)
	stdout.write(out[1][1].getvalue())
print 0,0
