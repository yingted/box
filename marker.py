#!/usr/bin/python2 -SOO
from datetime import datetime
from subprocess import check_output
def read(path):
    data = ''
    with open(path) as f:
        data = f.read()
    return data
score_sub_s=[]
for x in check_output(("find","code","-mindepth","3","-name","solution.*","-type","f","-print0")).split("\0")[:-1]:
    try:
        score_sub_s.append((map(int,read(x[:x.rindex("/")]+"/score").split("\n")[-2].split(" ")),x.split("/")))
    except:
        pass
scores=dict([((p[1],read("/".join(p[:3])+"/in").rstrip("\n")),(s,int(p[2])))for(s,p)in sorted(score_sub_s)])
av=list(map(lambda x:x.split('='),read('points').split('\n')[:-1]))
points={x:int(y) for x,y in av}
for u in map(lambda x:x.split('=')[0],read('users').split('\n')[:-1]):
    print(u+':')
    total=0
    for p,_ in av:
        print p+' ('+str(points[p])+' pts):',
        if (u,p) not in scores: print 'No submission'
        else:
            s,t = scores[(u,p)]
            x = int(round(float(points[p])*float(s[1])/float(s[0])))
            total += x
            print '%d (%d/%d), submitted on %s'%(x,s[1],s[0],str(datetime.fromtimestamp(t)))        
    print 'Total = '+str(total)
    print
