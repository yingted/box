var x, y, z, happy, a, b, v : int

happy := 0
get x,y,z

for i: 1..y
    get a, b, v
    if z >= a and z <= b then
        happy += v
    end if
end for

put happy
