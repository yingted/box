for(;([m,n,s,j]=readline().split(" ").map(Number))[0];print(a[j-1]==Infinity?-1:a[j-1])){
	for(var a=[];a.length<n;a.push(a.length==s-1?0:Infinity));
	while(m--){
		for(var i=0,b=readline().split("|").slice(1,n),c=[];i<b.length;++i)
			if(b[i]=="-")
				[c[i],c[++i]]=[a[i+1],a[i]];
			else if(b[i+1]!=="-"){
				c[i]=Math.min(a[i],a[i+1]+1);
				c[i+1]=Math.min(a[i]+1,a[i+1]);
			}else c[i]=a[i];
		c[i]=a[i];
		a=c;
	}
}
