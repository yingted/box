#!/usr/bin/python
import itertools
a=[sum(map(ord,x))-len(x)*64 for x in itertools.izip_longest(*raw_input().split(),fillvalue='@')]
x=0
for i in xrange(len(a)):
	a[i]+=x-1
	x,a[i]=divmod(a[i],26)
while x: #compensate for python lists
	x-=1
	a.append(x%26)
	x/=26
print"".join(chr(c+65)for c in reversed(a))
