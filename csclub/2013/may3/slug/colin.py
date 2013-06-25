for _ in range(int(input())):
    alphabeta="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
    s=input()
    s=s.lower()
    s=s.replace("'",'').replace('"','').replace('`','')
    ns=''
    for x in s:
        if x in alphabeta:ns+=x
        else:ns+='_'
    #print(ns)
    ns=ns.strip('_')
    slug=''
    under=0
    for x in ns:
        if x!='_':
            under=0
            slug+=x
        elif x=='_' and not under:
            under=1
            slug+=x
    print(slug)
