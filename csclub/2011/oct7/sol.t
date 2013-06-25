function pdet(a,b,c:array 1..2of int):boolean
    result (a(1)-b(1))*(c(2)-b(2))>(a(2)-b(2))*(c(1)-b(1))
end pdet
var inp,out,n,m:int
open:inp,"input.txt",get
open:out,"output.txt",put
loop
    get:inp,n,m
    exit when n=0
    var a:array 0..n-1of array 1..2of int
    for i:0..n-1
        get:inp,a(i)(1),a(i)(2)
    end for
    for:1..m
        var p:array 1..2of int
        get:inp,p(1),p(2)
        var c:=0
        for i:0..n-1
            if a(i)(2)>p(2)then
                if a((i+1)mod n)(2)<=p(2)and pdet(a((i+1)mod n),p,a(i))then
                    c-=1
                end if
            elsif a((i+1)mod n)(2)>p(2)and pdet(a(i),p,a((i+1)mod n))then
                c+=1
            end if
        end for
        put:out,c
    end for
end loop
close:out
