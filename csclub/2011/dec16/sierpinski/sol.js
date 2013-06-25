while(([m,n]=readline().split(" ").map(Number)).some(Boolean))
	print((m&~(m+n)?"Bob":"Alice")+" wins");
