#!/usr/bin/python
from random import shuffle,choice
v,e,n=map(int,raw_input().split())
print v,min(e,v*v),min(n,v),int((9000**2+1)/(v+e))
def shuffled(x):
	shuffle(x)
	return x
for(x,y)in shuffled([choice(((i,j),(j,i)))for i in xrange(v)for j in xrange(i,v)])[:e]:
	print x,y
print' '.join(map(str,shuffled(range(v))[:n]))
