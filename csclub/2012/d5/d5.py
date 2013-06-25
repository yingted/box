#!/usr/bin/python
inp=file("DATA5.txt")
out=file("OUT5.txt","w")
z=(1,0),(-1,0),(0,-1),(0,1)
for _ in xrange(5):
	n=int(inp.readline())
	a=[map(str,inp.readline())for _ in xrange(n)]
	h=[[[False]*7 for _ in xrange(n)]for _ in xrange(n)]
	for i in xrange(n):
		for j in xrange(n):
			if a[i][j]=="B":
				x=i
				y=j
				a[i][j]='.'
				break
	def dfs(x,y,c):
		h[x][y][c]=True
		C=0
		S=0
		for dx,dy in z:
			dx+=x
			dy+=y
			if dx>=0 and dx<n and dy>=0 and dy<n:
				if a[dx][dy]=='*':
					if h[dx][dy][c+1]:
						continue
					a[dx][dy]='.'
					C2,S2=dfs(dx,dy,c+1)
					a[dx][dy]='*'
					C2+=1
					S2+=1
				elif a[dx][dy]in".abcdef"[:c+1]:
					if h[dx][dy][c]:
						continue
					C2,S2=dfs(dx,dy,c)
					S2+=1
				else:
					continue
				if C2>C:
					C=C2
					S=S2
				elif C2==C:
					S=min(S,S2)
		h[x][y][c]=False
		return C,S
	c,s=dfs(x,y,0)
	out.write(str(c)+" "+str(s)+"\n")
