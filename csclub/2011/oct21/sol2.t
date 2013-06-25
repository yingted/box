var inp, out, n : int
const ans : array 0 .. * of int := init (1, 1, 0, 0, 2, 10, 4, 40, 92, 352, 724, 2680, 14200, 73712, 365596, 2279184, 14772512, 95815104, 666090624)
open : inp, "input2.txt", get
open : out, "output2.txt", put
loop
    get : inp, n
    exit when n>upper(ans)
    put : out, ans (n)
end loop
close : inp
close : out
