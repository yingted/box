#!/usr/bin/python
import sys
close={"(":")","[":"]","{":"}","<":">"}
raw_input()
for s in sys.stdin:
	try:
		x="\n"
		while x or s:
			x=x[1:]if s[0]==x[0]else close[s[0]]+x
			s=s[1:]
		print 1
	except:
		print 0
