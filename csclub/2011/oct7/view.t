%include "sol.t"
var inp,out,n,m:int
open:inp,"input.txt",get
open:out,"output.txt",get
setscreen("graphics:800;600;nocursor;offscreenonly")
loop
    get:inp,n,m
    exit when n=0
    cls
    var x,y:array 1..n of int
    var px,py,c:array 1..m of int
    var xl,xh,yl,yh:int
    xl:=maxint
    yl:=maxint
    xh:=minint
    yh:=minint
    for i:1..n
        get:inp,x(i),y(i)
        xl:=min(xl,x(i))
        yl:=min(yl,y(i))
        xh:=max(xh,x(i))
        yh:=max(yh,y(i))
    end for
    for i:1..m
        get:inp,px(i),py(i)
        get:out,c(i)
        xl:=min(xl,px(i))
        yl:=min(yl,py(i))
        xh:=max(xh,px(i))
        yh:=max(yh,py(i))
    end for
    xh-=xl
    yh-=yl
    const r:=min(maxx/xh,maxy/yh)
    const xb:=(maxx-r*(xh+2*xl))/2
    const yb:=(maxy-r*(yh+2*yl))/2
    for i:1..n
        x(i):=round(x(i)*r+xb)
        y(i):=round(y(i)*r+yb)
    end for
    drawfillpolygon(x,y,n,black)
    for i:1..m
        drawoval(round(px(i)*r+xb),round(py(i)*r+yb),ceil(sqrt(r)),ceil(sqrt(r)),c(i)+3)
    end for
    View.Update
    const ch:=getchar
end loop
