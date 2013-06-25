#!/usr/bin/python -SOO
import sys,itertools
inc=sorted([int("0"+"".join(x))for x in itertools.product(*[("",str(x))for x in xrange(1,10)])])
for x in map(int,sys.stdin.readlines())[1:]:
	if x>123456789:
		print 0
	else:
		i=511
		for d in 256,128,64,32,16,8,4,2,1:
			if inc[i-d]>=x:
				i-=d
		print inc[i]
