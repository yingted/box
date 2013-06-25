import "queens.t"
proc dfs (n : int)
    for i : 1 .. Queens.N
	if Queens.place (n, i) then
	    if n = 1 then
		Queens.check
		cls
		Queens.progress
		Queens.display ("board:")
	    else
		dfs (n - 1)
	    end if
	    Queens.remove (n, i)
	end if
    end for
end dfs
dfs (Queens.N)
Queens.solutions
