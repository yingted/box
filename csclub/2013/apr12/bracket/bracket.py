#!/usr/bin/python
import sys
close={"(":")","[":"]","{":"}","<":">"}
def suffix(s,x):
	if x or s:
		suffix(s[1:],x[1:]if s[0]==x[0]else close[s[0]]+x)
raw_input()
for x in sys.stdin:
	try:
		suffix(x,"\n")
		print 1
	except:
		print 0
