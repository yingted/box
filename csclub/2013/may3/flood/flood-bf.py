#!/usr/bin/python -SOO
while True:
	r,c=map(int,raw_input().split())
	if r==c==0:
		break
	a=[raw_input()for _ in xrange(r)]
	M=r+c-1
	for i0 in xrange(r):
		for j0 in xrange(c):
			q=[(i0,j0)]
			seen={q[0]}
			m=-1
			while q:
				m+=1
				if m>=M:
					break
				nq=[]
				for i,j in q:
					for I,J in(i-1,j),(i,j-1),(i,j+1),(i+1,j):
						if(I,J)not in seen and 0<=I<r and 0<=J<c:
							seen.add((I,J))
							(nq if a[i][j]!=a[I][J]else q).append((I,J))
				q=nq
			M=min(M,m)
	print M
