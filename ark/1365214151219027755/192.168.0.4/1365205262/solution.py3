    '''
    Created on Apr 5, 2013
     
    @author: Colin Lee
    '''
     
    def ss(x):
        lx=list(map(int,list(str(x))))
    #   print(x)
        for i in range(len(lx)-1):
            if lx[i+1]-lx[i]<=0:
                return (str(x)[:i],str(x)[i:])
        return False
    n=int(input())
    for _ in range(n):
        k = int(input())
        if k>123456789: print('0')
        else:
            ret=ss(k)
            if ss(k):
                p,w=ss(k)
    #            print(p,w)
                if len(p)==0:
                    if len(w)+int(w[0])<=10:
                        t=''.join([str(x) for x in range(int(w[0]),len(w)+int(w[0]))])
                        if int(t)>int(w):
                            print(t)
                        else: print(''.join([str(x) for x in range(1,len(w)+2)]))
                    else:
                        print(''.join([str(x) for x in range(1,len(w)+2)]))
        #       print(w[0],len(w))
                else:
                    if 10-int(w[0])>=len(w):
            #           print('av')
                        if int(w[0])+len(w)<=10:
                            a=w[0]+''.join([str(x) for x in range(int(w[0])+1,int(w[0])+len(w))])
                            print(p+a)
                        else: print( ''.join([str(x) for x in range(1,len(str(k))+2)]))
                    else:
            #           print(p[-1])
                        left=str(int(p[-1])+1)
                        if int(p[-1])+len(w)+2<=10:
                            right=''.join([str(x) for x in range(int(p[-1])+2,int(p[-1])+len(w)+2)])
                            print(left+right)
                        else: print( ''.join([str(x) for x in range(1,len(str(k))+2)]))
            else:print(k)
#