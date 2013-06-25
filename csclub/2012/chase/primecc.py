#!/usr/bin/python
#http://stackoverflow.com/questions/2068372/fastest-way-to-list-all-primes-below-n-in-python/3035188#3035188
import numpy
def primes(n):
	""" Input n>=6, Returns a array of primes, 2 <= p < n """
	sieve = numpy.ones(n/3 + (n%6==2), dtype=numpy.bool)
	sieve[0] = False
	for i in xrange(int(n**0.5)/3+1):
		if sieve[i]:
			k=3*i+1|1
			sieve[	  ((k*k)/3)	  ::2*k] = False
			sieve[(k*k+4*k-2*k*(i&1))/3::2*k] = False
	return numpy.r_[2,3,((3*numpy.nonzero(sieve)[0]+1)|1)]
#my code!
import sys
n=int(sys.argv[1])if len(sys.argv)>1 else input()
a=primes(n)
s=numpy.sum(a)
print s,s,len(a),(9000**2+1)/2/s
s=0
b=[]
for p in a:
	b.append(str(s))
	for x in xrange(p):
		print s+x,s+(x+1)%p
	s+=p
print' '.join(b)
