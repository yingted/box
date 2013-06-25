for _ in xrange(5):
	x,y,z=map(int,raw_input().split())
	s=0
	for _ in xrange(y):
		a,b,v=map(int,raw_input().split())
		if a<=z<=b:
			s+=v
	print s
