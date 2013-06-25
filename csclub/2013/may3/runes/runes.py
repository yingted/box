#!/usr/bin/python -SOO
from itertools import combinations
from fractions import gcd
while True:
	a=[map(int,raw_input().split())for _ in xrange(int(raw_input()))]
	if not a:
		break
	out=[]
	count={}
	for(ax,ay),(bx,by),(cx,cy)in combinations(a,3):
		a2=ay*ay+ax*ax
		b2=by*by+bx*bx
		c2=cy*cy+cx*cx
		kd2=(ax-bx)*cy+(by-ay)*cx-ax*by+ay*bx
		kdx=(ay-by)*c2+(b2-a2)*cy+a2*by-ay*b2
		kdy=(bx-ax)*c2+(a2-b2)*cx+ax*b2-a2*bx
		k=(ax*by-ay*bx)*c2+(a2*bx-ax*b2)*cy+(ay*b2-a2*by)*cx
		g=gcd(gcd(gcd(kd2,kdx),kdy),k)
		circ=kd2/g,kdx/g,kdy/g,k/g
		count[circ]=count.get(circ,0)+1
	for v in count.itervalues():
		if v>3:
			out.append(int(2+(6*v)**(1./3)))
	print" ".join(map(str,sorted(out,reverse=True)))
