function regress (var a : array 1 .. * of int) : int
    var sum := a (upper (a))
    for i : 2 .. upper (a)
	for decreasing j : upper (a) .. i
	    a (j) -= a (j - 1)
	end for
	sum += a (upper (a))
    end for
    result sum
end regress
function fun (x : int) : int
    result x**5-x**4*5+x**2-(x**3-x)*(1-4*x*(x-1))+23+(x*(x+1)*(x+2)*(x+3)*(x+4)*(x+5)*(x+6))div 1680
end fun
const N := 10
var pairs : array 1 .. * of int := init (
1,  2,          2,
5,  25,         0, 1, 4, 9, 16,
8,  -127,       1, 0, 1, 0, 1, 0, 1, 0,
16, 32768,      0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384,
N,0,0,0,0,0,0,0,0,0,0,0,
)
pairs (upper (pairs) - N) := fun (N + 1)
for i : 1 .. N
    pairs (upper (pairs) - N + i) := fun (i)
end for
var i := 1
loop
    exit when i > upper (pairs)
    var arr : array 1 .. pairs (i) of int
    for j : 1 .. pairs (i)
	arr (j) := pairs (i + 1 + j)
    end for
    assert pairs (i + 1) = regress (arr)
    i += 2 + pairs (i)
end loop
put "success!"
