'''
Created on Apr 5, 2013

@author: Colin Lee
'''

for _ in range(5):
    l,k,g=[int(x) for x in input().strip().split()]
    m=[]
    for i in range(k):
        m.append([int(x) for x in input().strip().split()])
    print(sum([x[2] for x in m if x[0]<=g<=x[1]]))