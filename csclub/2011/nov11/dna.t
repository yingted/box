function dna (a, b : string) : string
    var stored : array 0 .. length (a), 0 .. length (b) of int
    for i : 0 .. length (a)
	stored (i, 0) := 0
    end for
    for i : 1 .. length (b)
	stored (0, i) := 0
    end for
    for i : 1 .. length (a)
	for j : 1 .. length (b)
	    %you may add code here
	    if a (i) = b (j) then
		%you may add code here
	    end if
	end for
    end for
    var output := ""
    var i := length (a)
    var j := length (b)
    loop
	exit when i = 0| j = 0
	if stored (i, j - 1) = stored (i, j) then
	    j -= 1
	elsif stored (i - 1, j) = stored (i, j) then
	    i -= 1
	else
	    assert a (i) = b (j) & stored (i, j) = stored (i - 1, j - 1) + 1
	    %you may add code here (more than one line)
	    i -= 1
	    j -= 1
	end if
    end loop
    result output
end dna
const pairs : array 1 .. * of string := init ("cctaag", "cttagg", "ctag",
    "aaazaacccxccctttbtggggaa", "aaataaccaccccttxttggaggaba", "aaaaaccccccttttggggaa")
for i : 1 .. upper (pairs) - 2 by 3
    assert dna (pairs (i), pairs (i + 1)) = pairs (i + 2) & Time.Elapsed < 200
end for
put "success!"
