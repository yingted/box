def get(n):
	a=[raw_input()for _ in xrange(n)]
	wa=max(map(len,a))
	return[s+" "*(wa-len(s))for s in a],wa
while True:
	n,m=map(int,raw_input().split())
	if n==m==0:
		break
	a,wa=get(n)
	b,wb=get(m)
	out=[]
	for di in xrange(n-m+1):
		for dj in xrange(wa-wb+1):
			if all(a[i+di][dj:dj+wb]==b[i]for i in xrange(m)):
				before=a[di][:dj]
				out.append((~di,len(before)-before.count(" ")+1))
	print len(out)
	for x in out:
		print"level %d point %d"%x
