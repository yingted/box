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
	def maxcost(v,c):
		s=0
		for i in xrange(n):
			if not v&(1<<i):
				s+=dist[i][c]
				c=i
		return s
	q=[]
	for l in xrange(n):
		q.append((mincost(1<<l,l),0,1<<l,l))#heuristic, actual, visited, last
		best[l][1<<l]=0
	w=maxcost(1,0)
	while q:
		h,c,v,l=heappop(q)
		w=min(w,c+maxcost(v,l))
		if v==done:
			break
		if h<w and best[l][v]==c:
			for i in xrange(n):
				I=1<<i
				if not v&I:
					d=dist[l][i]
					if v|I not in best[l]or best[l][v|I]>c+d:
						best[i][v|I]=c+d
						heappush(q,(c+d+mincost(v|I,i),c+d,v|I,i))
	print"%.4f"%w
