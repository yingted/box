from random import randrange
from sys import maxint,argv
n=input()if len(argv)<2 else int(argv[1])
for _ in xrange(10):
	print n,' '.join([str(randrange(0,1000))for _ in xrange(n)])
