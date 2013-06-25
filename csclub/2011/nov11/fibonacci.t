const MAX := 45
var stored : array 2 .. MAX of int
for i : 2 .. MAX
    stored (i) := 0
end for
function fibonacci (n : int) : int
    assert n >= 0
    if n < 2 then
	result n
    elsif stored (n) = 0 then
	%you may add code here
    end if
    result fibonacci (n - 1) + fibonacci (n - 2) %you may change this line
end fibonacci
const pairs : array 1 .. * of int := init (0, 0, 1, 1, 2, 1, 5, 5, 20, 6765,30, 832040, 45, 1134903170, 44, 701408733, 43, 433494437)
for i : 1 .. upper (pairs) - 1 by 2
    assert fibonacci (pairs (i)) = pairs (i + 1) & Time.Elapsed < 100
end for
put "success!"
