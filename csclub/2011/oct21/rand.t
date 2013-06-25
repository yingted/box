var inp:int
open:inp,"input_random.txt",put
for m:10..100 by 10
    for n:10..100 by 10
	put:inp,m," ",n
	const ai:=Rand.Int(1,m)
	const aj:=Rand.Int(1,n)
	var bi,bj:int   
	loop
	    bi:=Rand.Int(1,m)
	    bj:=Rand.Int(1,n)
	    exit when ai~=bi|aj~=bj
	end loop
	for i:1..m
	    for j:1..n
		if i=ai&j=aj then
		    put:inp,'A'..
		elsif i=bi&j=bj then
		    put:inp,'B'..
		elsif i=bi&j=bj+1|Rand.Real<.1 then
		    put:inp,'#'..
		else
		    put:inp,'.'..
		end if
	    end for
	    put:inp,""
	end for
    end for
end for
put:inp,"0 0"
close:inp
