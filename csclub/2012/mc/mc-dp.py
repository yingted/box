#!/usr/bin/python
while True:
	x=raw_input()
	if x=="-":
		break
	n=len(x)
	inf=float("inf")
	best=[[inf]*(1<<n)for _ in xrange(n)]
	x=map(ord,x)
	dist=[[((i-j)**2+(x[i]-x[j])**2)**.5 for j in xrange(n)]for i in xrange(n)]
	q=[]
	for l in xrange(n):
		best[l][1<<l]=0
		q.append((l,1<<l))
	for c,v in q:
		d=best[c][v]
		dc=dist[c]
		for i in xrange(n):
			I=1<<i
			if not v&I:
				I|=v
				bi=best[i]
				if bi[I]==inf:
					q.append((i,I))
				bi[I]=min(bi[I],d+dc[i])
	print"%.4f"%min(best[l][(1<<n)-1]for l in xrange(n))
