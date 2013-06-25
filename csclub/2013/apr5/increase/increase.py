#!/usr/bin/python -SOO
import sys
def dfs(x,prev=-1):
	if prev<=9:
		if x:
			if x[0]>=prev+1:#bound
				ret=dfs(x[1:],x[0])
				if ret is not None:
					return str(x[0])+ret
				prev=x[0]
			len_x=len(x)
			if prev+len_x<=9:#free
				return"".join(map(str,xrange(prev+1,prev+len_x+1)))
		else:
			return""
for x in map(int,sys.stdin)[1:]:
	if 0<x<=123456789:
		print dfs(map(int,"0"+str(x))).lstrip("0")
	else:
		print 0
