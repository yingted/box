//usr/bin/js
n=1e5;
print(n)
for(var i=0,a=Math.PI*2/n,b=1e9;i<n;++i)
	print(((Math.cos(i*a)+1)*b+.5)|0,((Math.sin(i*a)+1)*b+.5)|0);
