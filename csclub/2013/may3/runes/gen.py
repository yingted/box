#!/usr/bin/python
from random import *
from math import *
from sys import argv
n,t=map(int,argv[1:])
#from http://pydec.googlecode.com/svn-history/r10/trunk/pydec/math/circumcenter.py
from numpy import bmat, hstack, vstack, dot, sqrt, ones, zeros, sum, asarray, linspace
from numpy.linalg import solve,norm
def circumcenter_barycentric(pts):
	pts = asarray(pts)
	rows,cols = pts.shape
	assert(rows <= cols + 1)
	A = bmat( [[ 2*dot(pts,pts.T), ones((rows,1)) ],
		   [  ones((1,rows)) ,  zeros((1,1))  ]] )
	b = hstack((sum(pts * pts, axis=1),ones((1))))
	x = solve(A,b)
	bary_coords = x[:-1]  
	return bary_coords
def circumcenter(pts):
	pts = asarray(pts)
	bary_coords = circumcenter_barycentric(pts)
	center = dot(bary_coords,pts)
	radius = norm(pts[0,:] - center)
	return (center,radius)
def intspace(lo=5,hi=n,num=t):
	return map(int,linspace(lo,hi,num))
def randpt():
	return randint(-1000,1000),randint(-1000,1000)
bias={4:1e-2,5:1e-1}
for N in intspace():
	print N
	seen=set()
	while len(seen)<N:
		pts=set(randpt()for _ in xrange(3))
		C,r=circumcenter(list(pts))
		for x in xrange(max(-1000,int(ceil(C[0]-r))),min(1001,int(floor(C[0]+r)+1))):
			dx=x-C[0]
			dy=(r**2-dx**2)**.5
			for y in set((max(-1000,int(round(C[1]+dy))),min(1000,int(round(C[1]-dy))))):
				if abs((dx**2+(y-C[1])**2)**.5-r)<1e-5:
					pts.add((x,y))
		l=len(pts)
		if l>3:
			if l not in bias or random()<bias[l]:
				seen.update(pts)
	pts=list(seen)[:N]
	shuffle(pts)
	assert len(pts)==N
	for x,y in pts:
		print x,y
def grid(x,y,r):
	a=[(i,j)for i in x for j in y]
	shuffle(a)
	a=a[:r]
	print len(a)
	for i,j in a:
		print i,j
def randseq(n):
	s=randint(1,1000/(n-1))
	l=randint(-1000,1001-s*n)
	return xrange(l,l+s*n,s)
for i in intspace(hi=int(n**.5/.3)):
	grid(randseq(i),randseq(i),int(i*i*.3))
print"""\
0"""
