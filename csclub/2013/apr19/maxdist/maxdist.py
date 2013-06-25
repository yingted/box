import sys
from itertools import izip
n,d=map(int,raw_input().split())
m=[map(int,sys.stdin.readlines())]
M=m[:]
while m[-1]:
	m.append(map(min,izip(m[-1],m[-1][2**(len(m)-1):])))
	M.append(map(max,izip(M[-1],M[-1][2**(len(M)-1):])))
best,start,end,lb=0,0,1,0
while end<=n:
	#lb=int(log(end-start,2)) is preferred if the language supports it
	exp=2**lb#highest set bit=2**(binary logarithm)
	if max(M[lb][start],M[lb][end-exp])-min(m[lb][start],m[lb][end-exp])<=d:
		best=max(best,end-start)
		end+=1
		if end-start>=2*exp:
			lb+=1
	else:
		start+=1
		if end-start<exp:
			lb-=1
print best
