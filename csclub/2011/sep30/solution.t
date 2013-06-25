%optimal solution for the problem
%declare the node linked list type, useful for sets
type node :
    record
	n : int%id
	c : int%cost
	next : ^node
    end record
%procedure to prepend a list element
procedure add (var list : ^node, n : int, c : int)
    var e : ^node%new element
    new e
    e->n := n
    e->c := c
    e->next := list
    list := e
end add
%declare the number of vertices, edges, max price, and input stream
var v, e, h, fd : int
%declare the "waiting" set of nodes
var a : ^node
a := nil
%open the file for reading
open : fd, "input.txt", get
%read in our constants
get : fd, v, e, h
const inf := h + 1
%initialize the list of nodes to an empty value
var l : array 1 .. v of ^node
var p : array 1 .. v of int
for decreasing i : v .. 1
    l (i) := nil
    p (i) := inf
end for
%mark the first vertex as free
p (1) := 0
add (a, 1, 0)
%read in all the edges
for : 1 .. e
    var f, t, d : int%from, to, distance
    get : fd, f, t, d
    add (l (f), t, d)
end for
close : fd
loop
    exit when a = nil%exit when we have considered all nodes
    var b := a%copy the nodes to be processed
    a := nil%empty out the nodes to be processed
    loop
	var c := l (b->n)%for each node, read the list of targets
	loop
	    exit when c = nil%for each target
	    if p (c->n) = inf then%if we have not considered the target
		add (a, c->n, 0)%add the target (the cost value is useless)
	    end if
	    p (c->n) := min (h, min (p (c->n), p (b->n) + c->c))%the cost is
		%the lowest of the purchase price, this creation price, or any
		%other creation price
	    c := c->next
	end loop
	b := b->next
	exit when b = nil
    end loop
end loop
open : fd, "output.txt", put
for i : 1 .. v
    put : fd, h - p (i)%print purchase price less your price
end for
close : fd
