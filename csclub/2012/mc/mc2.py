#!/usr/bin/python
from heapq import *
while True:
	x=raw_input()
	if x=="-":
		break
	n=len(x)
	best=[{}for _ in xrange(n)]
	x=map(ord,x)
	dist=[[((i-j)**2+(x[i]-x[j])**2)**.5 for j in xrange(n)]for i in xrange(n)]
	done=(1<<n)-1
	def mincost(v,c):
		x=y=c
		for i in xrange(c):
			if not v&(1<<i):
				x=i
				break
		for i in xrange(n-1,c,-1):
			if not v&(1<<i):
				y=i
				break
		return min(dist[c][x],dist[c][y])+dist[x][y]
	q=[]
	for l in xrange(n):
		q.append((mincost(1<<l,l),0,1<<l,l))#heuristic, actual, visited, last
		best[l][1<<l]=0
	while q:
		h,c,v,l=heappop(q)
		if v==done:
			print"%.4f"%h
			break
		for i in xrange(n):
			I=v|1<<i
			if I!=v:
				d=c+dist[l][i]
				if I not in best[l]or best[l][I]>d:
					best[i][I]=d
					heappush(q,(d+mincost(I,i),d,I,i))
