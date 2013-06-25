from random import *
import sys
S=int(sys.argv[1])#15 for small, 50 for large
for _ in xrange(10):
	r=randint(1,S)
	c=randint(1,S)
	print r,c
	for _ in xrange(r):
		l=bin(getrandbits(c))[2:]
		l="0"*(c-len(l))+l
		print l.replace("0","b").replace("1","w")
print 0,0
