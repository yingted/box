for _ in range(5):
    f,m=[int(x) for x in input().strip().split()]
    fem=[]
    men=[]
    
    for x in range(f):
        fem.append(int(input()))
    for x in range(m):
        men.append(int(input()))
    c=0
    fem.sort()
    men.sort()
    p=len(men)
    while True:
        if len(fem)==0:break
        maxf=fem.pop()
        maxmp=-1
        maxm=-1
        for i in reversed(range(p)):
            if men[i]<maxf:
                maxmp=i
                p=i
                break
        if maxmp==-1:break
        c+=1
    print(c)
