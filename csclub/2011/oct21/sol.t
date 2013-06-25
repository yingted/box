var inp, out, m, n : int
open : inp, "input.txt", get
open : out, "output.txt", put
loop
    get : inp, m, n
    exit when m = 0
    var a : array 1 .. m, 1 .. n, 0 .. 1 of int %we define a(i,j,type) where type can be 0 or 1
    var ch : char %for input purposes
    for i : 1 .. m
	for j : 1 .. n
	    get : inp, ch
	    a (i, j, 0) := 1 - index ("A.#B", ch) %classify the letter
	    a (i, j, 1) := a (i, j, 0)
	    if a (i, j, 0) = 0 then
		a (i, j, 1) := -1 %force the first portal type to be 0
	    end if
	end for
	get : inp, ch %get rid of the newline
    end for
    var ans, cur := 0 %start at pair 0
    loop
	ans := -1 %default the answer+1 to 0 (impossible)
	for k : 0 .. 1 %for each type
	    for i : 1 .. m %for each row
		for j : 1 .. n %for each column
		    if a (i, j, k) = cur then %if we set the value last iteration
			for I : -1 .. 1 %for each direction (north/south)
			    for J : -1 .. 1 %for each direction (east/west)
				if I * I ~= J * J then %if the direction is N, S, E, or W
				    var K := 1 %look ahead one block in this direction
				    loop %loop until we hit the wall or an obstacle
					exit when i + I * K < 1| i + I * K > m| j + J * K < 1| j + J * K > n| a (i + I * K, j + J * K, 1 - k) = -2
					K += 1 %increase the distance each time
				    end loop
				    K -= 1 %back up one
				    if K > 0 then %if we have moved (i.e. can cast a portal)
					if a (i + I * K, j + J * K, 1 - k) = -1 then %if the space is empty, cast a portal
					    ans := -2 %we need to update the answer since we cast a portal
					    a (i + I * K, j + J * K, 1 - k) := cur + k %increase the pair number only if we're on the second portal in the pair
					elsif k = 0 and a (i + I * K, j + J * K, 1) = -3 then %if we've reached the destination
					    ans := cur %copy over than answer
					    exit
					end if
				    end if
				    exit when ans >= 0
				end if
				exit when ans >= 0
			    end for
			    exit when ans >= 0
			end for
		    end if
		    exit when ans >= 0
		end for
		exit when ans >= 0
	    end for
	    exit when ans >= 0
	end for
	exit when ans > -2 %if the answer doesn't need updating
	cur += 1 %move to the next round
    end loop
    /*for k : 0 .. 1
     put k
     for i : 1 .. m
     for j : 1 .. n
     if a (i, j, k) < 0 then
     put ".#B" (-a (i, j, k)) ..
     else
     put a (i, j, k) ..
     end if
     end for
     put ""
     end for
     end for*/
    put : out, ans + 1     %output the pair number (increased by one because we count from zero here)
end loop
close : inp
close:out
