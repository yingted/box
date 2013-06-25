#!/usr/bin/env python3
from heapq import *
from itertools import chain
class DisjointSet:
    def __init__(self):
        self.p,self.rank = self,0
    def find(self):
        if self != self.p:
            self.p = self.p.find()
        return self.p
    def union(self,other):
        x,y = self.find(), other.find()
        if x==y:
            return
        elif x.rank < y.rank:
            x.p = y
        else:
            y.p, x.rank = x, x.rank+(x.rank==y.rank)
mstval = {}
def mst(e,n,x):
    if x in mstval:
        return mstval[x]
    vs,t = [DisjointSet() for _ in range(n)], 0
    for w,u,v in e:
        if x&(1<<u) and x&(1<<v) and vs[u].find()!=vs[v].find():
            vs[u].union(vs[v])
            t += w
    mstval[x] = t
    return t
while exec('s=input().strip();n=len(s)') or s!='-':
    mstval,e,visited = {},sorted(chain.from_iterable([(((i-j)**2+(ord(s[i])-ord(s[j]))**2)**0.5,i,j) for j in range(i+1,n)] for i in range(n-1))),set()
    h = [(mst(e,n,(1<<n)-1),0,((1<<n)-1)&~(1<<i),i) for i in range(n)]
    heapify(h)
    while True:
        _,d,x,u = heappop(h)
        visited.add((x,u))
        if x==0:
            print('{:.4f}'.format(d))
            break
        for v in range(n):
            if x&(1<<v) and (x&~(1<<v),v) not in visited:
                heappush(h,(lambda k:(k+mst(e,n,x),k,x&~(1<<v),v))(d+((u-v)**2+(ord(s[u])-ord(s[v]))**2)**0.5))
