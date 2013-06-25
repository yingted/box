function rq(a:array 1..* of int,b,c:array 1..* of boolean,lo,hi:int):int
    assert hi>=lo
    var m,M:int
    m:=a(lo)
    M:=a(lo)
    for i:lo+1..hi
	m:=min(m,a(i))
	M:=max(M,a(i))
    end for
    result M-m
end rq
var inp,out,n,d:int
open:inp,"input.txt",get
out:=0%open:out,"output.txt",put
loop
    get:inp,n,d
    exit when n=0
    var a:array 1..n of int
    var b,c:array 1..n of boolean
    for i:1..n
	get:inp,a(i)
    end for
    var lo,hi,m,M,best:int
    lo:=1
    hi:=1
    best:=0
    loop
	if rq(a,b,c,lo,hi)<=d then
	    best:=max(best,hi-lo)
	    hi+=1
	else
	    lo+=1
	end if
	exit when hi>n
    end loop
    put best+1
end loop
