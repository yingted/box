while True:
	n=input()
	if n<0:break;
	zeroes=0
	last=1
	while n>0:
		last=(last*(1,1,2,6,4)[n%5]*((6,2,4,8)[(n/5)%4]if n>4 else 1))%10
		n/=5
		zeroes+=n
	print str(last)+"u"+str(zeroes)
