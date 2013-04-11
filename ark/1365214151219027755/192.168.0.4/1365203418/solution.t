for : 1 .. 5
    var x, y : int
    var pairs : int := 0

    get x
    get y

    var xlist : array 1 .. x of int
    var ylist : array 1 .. y of int

    for i : 1 .. x
        get xlist (i)
    end for

    for i : 1 .. y
        get ylist (i)
    end for

    for : 1 .. x
        for i : 1 .. x - 1
            if xlist (i) > xlist (i + 1) then
                var temp : int
                temp := xlist (i)
                xlist (i) := xlist (i + 1)
                xlist(i + 1) := temp
            end if
        end for
    end for
    
    for : 1 .. y
        for i : 1 .. y - 1
            if ylist (i) > ylist (i + 1) then
                var temp : int
                temp := ylist (i)
                ylist (i) := ylist (i + 1)
                ylist (i + 1) := temp
            end if
        end for
    end for

    for i : 1 .. x
        var temp : int := 0
        var temp2 : int := 0
        for j : 1 .. y
            if ylist (j) <= xlist (i) and ylist (j) > 0 then
                temp := max (temp, ylist (j))
                if temp = ylist (j) then
                    temp2 := j
                end if
            end if
        end for
        if temp not= 0 and ylist (temp2) <= xlist (i) then
            pairs += 1
            ylist (temp2) := 0
        end if
    end for

    put pairs
end for