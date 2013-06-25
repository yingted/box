#!/usr/bin/python
inp=file("DATA2.txt")
out=file("OUT2.txt","w")
for d,n in map(lambda l:map(int,l.split()),inp):
	d=10*d/(d+n)
	out.write("*"*d+"."*(10-d)+'\n')
