#!/usr/bin/python -SOO
import random
from itertools import chain
while True:
    n,m = map(int,input().strip().split())
    m = min(m,n*(n-1)//2)
    print(n,m)
    if n==0: break
    s,t = set(range(n)), set()
    cur = random.sample(s,1).pop()
    s.remove(cur)
    t.add(cur)
    es = set(chain.from_iterable([(i,j) for j in range(i+1,n) if i!=j]for i in range(n-1)))
    #es = [[i==j for j in range(n)] for i in range(n)]
    while len(s):
        v = random.randint(0,n-1)
        if v not in t:
            print('{} {} {:.4f}'.format(cur,v,random.uniform(0.0001,1)))
            es.remove((min(cur,v),max(cur,v)))
            #es[cur][v] = es[v][cur] = True
            s.remove(v)
            t.add(v)
        cur = v
    for x,y in random.sample(es,m-n+1):
        print('{} {} {:.4f}'.format(x,y,random.uniform(0.0001,1)))
        
        
    
    
