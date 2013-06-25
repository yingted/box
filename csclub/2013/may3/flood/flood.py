#!/usr/bin/python -SOO
while True:
	r,c=map(int,raw_input().split())
	if r==c==0:
		break
	a=[list(raw_input())for _ in xrange(r)]
	M=r+c-1
	b=[]#blobs
	def makeblob(i,j):#make and return blob at i,j
		clr=a[i][j]
		blob=set()
		a[i][j]=len(b)
		for I,J in(i-1,j),(i,j-1),(i,j+1),(i+1,j):
			if 0<=I<r and 0<=J<c:
				if a[I][J]==clr:
					blob.update(makeblob(I,J))
				elif type(a[I][J])==int and a[I][J]!=a[i][j]:
					blob.add(a[I][J])
		return blob
	for i in xrange(r):
		for j in xrange(c):
			if type(a[i][j])!=int:#change colours to blobs
				b.append(list(makeblob(i,j)))
	for i in xrange(len(b)):#add reversed edges
		for j in b[i]:
			b[j].append(i)
	for i in xrange(len(b)):
		q=[i]
		seen={q[0]}
		m=-1
		while q:
			m+=1
			if m>=M:
				break
			nq=[]
			for i in q:
				for j in b[i]:
					if j not in seen:
						seen.add(j)
						nq.append(j)
			q=nq
		M=min(M,m)
	print M
