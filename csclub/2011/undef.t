/*%This is a file with interesting problems. The solutions are on this line.*/                                                                                                            function intIsUndefined (var x : int) : boolean result cheat (int, x) < minint end intIsUndefined function booleanIsUndefined (var x : boolean) : boolean result cheat (int1, x) mod 4 = 3 end booleanIsUndefined procedure intUndefine (var x : int) var undef : int cheat (nat, x) := cheat (nat, undef) end intUndefine procedure booleanUndefine (var x : boolean) bits (cheat (nat, x), 0 .. 1) := 3 /*bitwise or seems to hate some values*/ end booleanUndefine function waitForChar (ms : int) : char assert ms >= 0 const endTime := Time.Elapsed + ms loop if hasch then result getchar end if exit when Time.Elapsed > endTime delay (1) end loop result '\0' end waitForChar
/*^ To see the solutions, indent the file. To try to write them for yourself,
  \-move this percent sign to before the block comment so it's the first letter
    in the file to comment out the solutions on the first line. I provided
    solutions to prove it's doable with a reasonable amount of code.*/
var a : int
var b := 0
var c : boolean
var d := false
var e : array 1 .. 1 of int
var f : array 1 .. 1 of int := init (1)
assert intIsUndefined (a)
assert ~intIsUndefined (b)
intUndefine (b)
assert intIsUndefined (b)
assert booleanIsUndefined (c)
assert ~booleanIsUndefined (d)
booleanUndefine (d)
assert booleanIsUndefined (d)
assert intIsUndefined (e (1))
assert ~intIsUndefined (f (1))
put "type a letter in 5 seconds"
Input.Flush %not needed
const ch := waitForChar (5000)
if ch = '\0' then
    put "you did not type anything"
else
    put "you typed ", ch
end if
assert Time.Elapsed < 6000
