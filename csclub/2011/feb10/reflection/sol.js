function reflect(a,b,p){
	
};
for(;;){
	for(var[h,w]=readline().split(" ").map(Number),a=[],b=[];a.length<h;a.push(readline()));
	if(!h*w)break;
	for(var i=0;i<h;++i)
		for(var j=0;j<w;++j)
			if(a[i][j]=="*")
				b.push([i,j]);
	print(uneval(b));
}
