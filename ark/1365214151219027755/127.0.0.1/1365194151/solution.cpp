#!/usr/bin/python
for _ in xrange(5):
    n,m=map(int,raw_input().split())
	upper=iter(sorted([int(raw_input())for _ in xrange(n)]))
	y=sorted([int(raw_input())for _ in xrange(m)])
	c=0
	try:
		for val in y:
			while next(upper)<val:
				pass
			c+=1
	except StopIteration:
		pass
	print c
