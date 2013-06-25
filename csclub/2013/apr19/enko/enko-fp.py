#!/usr/bin/python -SOO
from heapq import heappush,heappop
while True:
	n,m=map(int,raw_input().split())
	if n==m==0:break
	tr=[[]for _ in xrange(n)]#transition probability
	for _ in xrange(m):
		x,y,p=raw_input().split()
		x,y=map(int,(x,y))
		p=float(p)
		tr[x].append((y,p))
		tr[y].append((x,p))
	q=[(-float(i==0),i) for i in xrange(n)]
	pr=[-float(i==0)for i in xrange(n)]#-probability
	while q:
		np,c=heappop(q)
		if c==n-1:break
		for i,p in tr[c]:
			if np*p<pr[i]:
				pr[i]=np*p
				heappush(q,(np*p,i))
	print"%.4f"%-pr[-1]
