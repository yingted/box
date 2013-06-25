var inp,out,n,d:int
open:inp,"input.txt",get
out:=0%open:out,"output.txt",put
loop
    get:inp,n,d
    exit when n=0
    var a:array 1..n of int
    for i:1..n
	get:inp,a(i)
    end for
    var best:=0
    for i:1..n
	var lo:=a(i)
	var hi:=a(i)
	var j:=i+1
	loop
	    exit when j>n
	    lo:=min(lo,a(j))
	    hi:=max(hi,a(j))
	    exit when hi-lo>d
	    j+=1
	end loop
	best:=max(best,j-i)
    end for
    put best
end loop
