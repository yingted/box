#!/usr/bin/python
from itertools import permutations
while True:
	x=raw_input()
	if x=="-":
		break
	n=len(x)
	x=map(ord,x)
	dist=[[((i-j)**2+(x[i]-x[j])**2)**.5 for j in xrange(n)]for i in xrange(n)]
	print min(sum(dist[i][j]for i,j in zip(x,x[1:]))for x in permutations(xrange(n)))
