#!/usr/bin/python -SOO
import sys,itertools
from bisect import bisect_left
inc=sorted([int("0"+"".join(x))for x in itertools.product(*[("",str(x))for x in xrange(1,10)])])
for x in map(int,sys.stdin)[1:]:
	print inc[bisect_left(inc,x)%512]
