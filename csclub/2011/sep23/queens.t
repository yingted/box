unit
module Queens
    export place, remove, count, N, display, check, solutions, progress, var A, var B
    /** Documentation
     *  O(1) time important methods (these are the actual useful methods):
     *  place (x, y : int) : boolean
     *      tries to place a queen at 1<=(x, y)<=N
     *      x is the row (left to right), and y is the column (top to bottom)
     *      returns: whether it was successful
     *  remove (x, y : int)
     *      removes a queen from (x, y)
     *      prints a message if the position was invalid
     *  count
     *      gets the number of queens on the board
     *  O(1) time debug methods:
     *  solutions
     *      prints the number of distinct solutions
     *  progress
     *      prints the number of distinct solutions and a progress bar
     *  O(N) time methods:
     *  check
     *      validates the distinctness of the solution and increases the count
     *  O(N^2) time methods:
     *  display (title : string)
     *      prints a text-based visual representation of the board
     *  Modifiable values
     *  N : int
     *      number of queens on the board (also the width and height)
     *  W : int
     *      width of the progress bar (you can substitute maxcol if you like)
     *      set it to maxcol if you've resized the gui terminal in your prefs
     *  A : int
     *      first colour for the chess board (second text colour)
     *  B : int
     *      second colour for the chess board (first text colour)
     *      set B := A to disable colouring
     */
    const N := 8                            %number of queens
    const W := 80                           %maxcol could be used instead
    var A := RGB.AddColour (1, .81, .7)     %top-left colour
    var B := black                          %other colour (higher contrast)
    %const B := RGB.AddColour (.81,.545,.28) %beige to match wikipedia boards
    %don't modify anything below here
    const CORRECT : array 0 .. * of int := init (1, 1, 0, 0, 2, 10, 4, 40, 92,
	352, 724, 2680, 14200, 73712, 365596, 2279184, 14772512, 95815104,
	666090624)
    var r, c : array 1 .. N of boolean
    var s : array 2 .. 2 * N of boolean
    var d : array 1 - N .. N - 1 of boolean
    var n := 0
    var valid := true
    var soln := 0
    type node : array 1 .. N of ^node
    var root : ^node
    new root
    for i : 1 .. N
	^root (i) := nil
    end for
    for i : 1 .. N
	r (i) := false
	c (i) := false
    end for
    for i : 2 .. 2 * N
	s (i) := false
    end for
    for i : 1 - N .. N - 1
	d (i) := false
    end for
    var occupied : array 1 .. N, 1 .. N of boolean
    for i : 1 .. N
	for j : 1 .. N
	    occupied (i, j) := false
	end for
    end for
    function place (x, y : int) : boolean
	if x < 1| x > N| y < 1| y > N| r (x)| c (y)| s (x + y)| d (x - y) then
	    result false
	end if
	occupied (x, y) := true
	r (x) := true
	c (y) := true
	s (x + y) := true
	d (x - y) := true
	n += 1
	result true
    end place
    procedure remove (x, y : int)
	if x < 1| x > N| y < 1| y > N| ~occupied (x, y) then
	    put "attempted to remove at ", x, ", ", y
	    valid := false
	    return
	end if
	occupied (x, y) := false
	r (x) := false
	c (y) := false
	s (x + y) := false
	d (x - y) := false
	n -= 1
    end remove
    function count : int
	result n
    end count
    procedure display (title : string)
	setscreen ("offscreenonly")
	put title
	for j : 1 .. N
	    for i : 1 .. N
		if A ~= B then
		    colour ((A xor B) * (i xor j and 1) xor B)
		    colourback ((A xor B) * (i xor j and 1) xor A)
		end if
		if occupied (i, j) then
		    put "Q " ..
		elsif r (i)| c (j)| s (i + j)| d (i - j) then
		    put ". " ..
		else
		    put "  " ..
		end if
	    end for
	    if A ~= B then
		colour (black)
		colourback (white)
	    end if
	    put ""
	end for
	setscreen ("nooffscreenonly")
    end display
    procedure check
	if n < N then
	    put "not enough queens on the board"
	    valid := false
	    return
	end if
	var cur := root
	var last := 0
	for i : 1 .. N
	    for j : 1 .. N
		if occupied (i, j) then
		    if last > 0 then
			if ^cur (last) = nil then
			    new ^cur (last)
			    for k : 1 .. N
				^ ( ^cur (last)) (k) := nil
			    end for
			end if
			cur := ^cur (last)
		    end if
		    last := j
		end if
	    end for
	end for
	if ^cur (last) = nil then
	    new ^cur (last)
	    soln += 1
	else
	    put "duplicate solution encountered"
	    valid := false
	end if
    end check
    procedure solutions
	if ~valid then
	    put "warning: invalid calls made"
	end if
	put "found ", soln ..
	if soln = 1 then
	    put " solution"
	else
	    put " distinct solutions"
	end if
    end solutions
    procedure progress
	if ~valid then
	    put "warning: invalid calls made"
	end if
	if soln = CORRECT (N) then
	    put "all " ..
	end if
	const w := round ((W - 2) * soln / CORRECT (N))
	put soln, " of ", CORRECT (N), " solutions, progress:\n[", repeat ("#"
	    , w), repeat (" ", W - w - 2), "]"
    end progress
end Queens
