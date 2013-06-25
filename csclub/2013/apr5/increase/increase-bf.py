#!/usr/bin/python -SOO
import sys
for x in map(int,sys.stdin)[1:]:
	try:
		print next(x for x in xrange(x,123456790)if not x or all([a<b for a,b in zip("0"+str(x),str(x))]))
	except StopIteration:
		print 0
