import "queens.t"
/* The 8 Queens problem
 * The problem is to arrange 8 queens on a chessboard so that no pair shares a
 *  row, column, or diagonal. For information about the api, please open the
 *  imported file and read the comments. You might want to make a backup and
 *  modify the file to help you debug (i.e. set N=4). In order to check the
 *  solution, your program should make a series of calls like the ones below.
 *  Of course, it shouldn't be hard-coded like this. The assert statements are
 *  there to make Turing happy (and to make sure I didn't mess this up).
 */
assert Queens.place (1, 4) and Queens.place (6, 5) and Queens.place (7, 1)
if Queens.place (3, 2) then
    put "a queen was placed at (3, 2), which is in line with (6, 5)"
else
    put "a queen cannot be placed at (3, 2)"
end if
assert Queens.place (4, 2)
Queens.display ("I plan to remove the queen at (4, 2):")
put "queens on the board: ", Queens.count, " out of ", Queens.N
Queens.remove (4, 2)
assert Queens.place (4, 8) and Queens.place (5, 2) and Queens.place (2, 7)
assert Queens.place (3, 3) and Queens.place (8, 6)
Queens.check
put "queens on the board: ", Queens.count,
    "; changing colour for debugging purposes"
Queens.B := RGB.AddColour (.81, .545, .28)
Queens.display ("the whole board")
Queens.progress
Queens.solutions
