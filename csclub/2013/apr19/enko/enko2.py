#!/usr/bin/python -SOO
from heapq import *
from math import exp,log
# this one prints out the optimal path found
while True:
    n,m = map(int,input().strip().split())
    if n==0: break
    graph = [[]for _ in range(n)]
    for _ in range(m):
        x,y,p = map(float,input().strip().split())
        x,y = map(int,(x,y))
        graph[x].append((y,-log(p)))
        graph[y].append((x,-log(p)))
    h = [(0 if i==0 else float('inf'),i) for i in range(n)]
    d = [0 if i==0 else float('inf') for i in range(n)]
    p = [-1]*n
    while h:
        k,u = heappop(h)
        if u==n-1: break
        for v,w in graph[u]:
            if k+w < d[v]:
                p[v] = u
                d[v] = k+w
                heappush(h,(k+w,v))
    print('{:.4f}'.format(exp(-d[-1])) if d[-1]<float('inf') else '0.0000')
    x,st = n-1,[n-1]
    while p[x]>=0:
        x = p[x]
        st.append(x)
    print(' '.join(map(str,st[::-1])))