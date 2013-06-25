if(!Array.prototype.some.call(arguments,function(e)e=="-n")){
	print(1000,1000)
	for(var i=0,v=0;i<1000;++i){
		for(var a=[];a.length<1000;a.push(String.fromCharCode(32+Math.random()*95|0)));
		print(a.join(""));
	}
}
print(10000);
var a=[
[.1,"swap",function()[]],
[.2,"fh",function()[]],
[.3,"fv",function()[]],
[.4,"cw",function()[]],
[.5,"ccw",function()[]],
[.6,"ofs",function(x,y)[x*2000|0-1000,y*2000|0-1000]],
[.7,"res",function(x,y)[x*500|0-250,y*500|0-250]],
[.8,"lin",function(x,y,dx,dy,l,c)[x*1000|0,y*1000|0,dx*2000|0-1000,dy*2000|0-1000,l*10000000|0,s[c*s.length|0]]],
[.85,"save",function(){if(++v>=1000)throw new Error();return[]}],
[.95,"load",function(){if(!v--)throw new Error();[]}],
[1,"out",function()[]],
];
for(var i=0;i<10000;++i){
	for(var r=Math.random(),j=0;r>=a[j][0];++j);
	for(var b=[];b.length<a[j][2].length;b.push(Math.random()));
	try{print(a[j][1],a[j][2].apply(this,b).join(" "))}catch(e){--i}
}
