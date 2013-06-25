#!/usr/bin/python
while True:
	x=raw_input()
	if x=="-":
		break
	n=len(x)
	x=map(ord,x)
	print"%.4f"%sum(((i-j)**2+(x[i]-x[j])**2)**.5for i,j in zip(xrange(n),xrange(1,n)))
