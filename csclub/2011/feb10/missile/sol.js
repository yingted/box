for(var[n,m]=readline().split(" ").map(Number),a=[];a.length<m;a.push(+readline()));
for(var b=[],last=0,idx=[-1],c=[[0]],out=[c];b.length<n;b.push(readline().split(" ").map(Number)));
b.sort(function(x,y)x[0]-y[0]);
a.map(function(e,j){
	var best=[];
	b.map(function([t,d],k){
		for(var i in c)
			if(t>=i+e&&(best[t]=[Math.max((best[t]||[0])[0],c[i][0]+d),[j,k]])[0]>idx[0])
				idx=best[t];
	});
	out.push(c=best);
});
for(b=b.map(function()"h");idx[1];idx=out[idx[1][0]])
	b[idx[1][1]]="c";
print(b.join(""));
