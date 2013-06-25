put"calculate n!"
put"n = "..
var n:int
get n
if n>12 then
    var x:real:=1
    for i:1..n
	x*=i
    end for
    put"n! = ",x
else
    var x:int:=1
    for i:1..n
	x*=i
    end for
    put"n! = ",x
end if
