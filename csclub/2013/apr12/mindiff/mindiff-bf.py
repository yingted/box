import sys
n,d=map(int,raw_input().split())
a=map(int,sys.stdin.readlines())
print min(max(sub)-min(sub)for sub in(a[i:i+d]for i in xrange(n-d)))
