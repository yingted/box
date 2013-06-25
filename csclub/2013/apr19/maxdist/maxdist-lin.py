import sys
from collections import deque
n,d=map(int,raw_input().split())
a=map(int,sys.stdin.readlines())
a.append(a[-1])
m=deque(((0,a[0]),))
M=deque(((0,a[0]),))
best,start,end=0,0,1
while end<=n:
	if M[0][1]-m[0][1]<=d:
		best=max(best,end-start)
		while m and a[end]<m[-1][1]:
			m.pop()
		m.append((end,a[end]))
		while M and a[end]>M[-1][1]:
			M.pop()
		M.append((end,a[end]))
		end+=1
	else:
		start=min(m[0][0],M[0][0])+1
		if start>m[0][0]:
			m.popleft()
		if start>M[0][0]:
			M.popleft()
print best
