//usr/bin/js
for(var re=/\bd="([^"]*)"/g,s=snarf(arguments[0]),m,xo=0,a=[],cf=1e5;m=re.exec(s);){
	var xlo=Infinity,ylo=Infinity,xhi=-Infinity;
	m=m[1].split(" ").map(function(l){
		var[x,y]=l.split(",");
		if(y===undefined)return;
		x=+x;y=+y;
		xlo=Math.min(xlo,x);
		xhi=Math.max(xhi,x);
		ylo=Math.min(ylo,y);
		return[x,y];
	}).filter(Boolean);
	var dx=xo-xlo;
	xo=dx+xhi;
	a.push.apply(a,m.map(function([x,y])(((x+dx)*cf+.5)|0)+" "+(((y-ylo)*cf+.5)|0)));
	if(m.length)
		a.push(a[a.length-m.length]);
}
print(a.length);
print(a.join("\n"));
