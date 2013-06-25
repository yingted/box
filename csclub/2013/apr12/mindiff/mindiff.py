import sys
from itertools import *
n,d=map(int,raw_input().split())
m=map(int,sys.stdin.readlines())
M=m[:]#copy
a=list(takewhile(lambda x:2*x<d,(2**i for i in count(0))))
a.append(d-1-sum(a))
for d in a:#dilate [0] by powers of 2 and a residual to get [0,n)
	m=map(min,izip(m,m[d:]))
	M=map(max,izip(M,M[d:]))
print min(imap(int.__sub__,M,m))
