#!/usr/bin/env python
from random import choice,randrange
from string import uppercase
lo,hi,nr=map(int,raw_input().split())
print" ".join("".join(choice(uppercase)for _ in xrange(randrange(lo,hi)))for _ in xrange(nr))
