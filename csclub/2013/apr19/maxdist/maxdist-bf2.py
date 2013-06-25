import sys
from itertools import *
n,d=map(int,raw_input().split())
a=map(int,sys.stdin.readlines())
try:
	print max([end-start for start in xrange(n)for end in xrange(start+1,n+1)if max(a[start:end])-min(a[start:end])<=d])
except ValueError:
	print 0
