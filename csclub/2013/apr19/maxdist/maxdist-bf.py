import sys
from itertools import *
n,d=map(int,raw_input().split())
a=map(int,sys.stdin.readlines())
a.append(a[-1])#prevent IndexError
best=0
for start in xrange(n):
	m=M=a[start]
	end=start
	while M-m<=d and end<=n:
		m=min(m,a[end])
		M=max(M,a[end])
		end+=1
	end-=1
	best=max(best,end-start)
print best
