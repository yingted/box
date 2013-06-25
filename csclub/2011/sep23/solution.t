import "queens.t"
proc dfs (n : int)
    for decreasing i : n - 1 .. 0
	if Queens.place (i div Queens.N + 1, i mod Queens.N + 1) then
	    if Queens.count = Queens.N then
		Queens.check
		cls
		Queens.progress
		Queens.display ("board:")
	    else
		dfs (i)
	    end if
	    Queens.remove (i div Queens.N + 1, i mod Queens.N + 1)
	end if
    end for
end dfs
dfs (Queens.N ** 2)
Queens.solutions
