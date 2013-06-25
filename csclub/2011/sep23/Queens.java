import java.awt.Color;
import java.util.HashSet;
import hsa.Console;
public class Queens
{
    /** Queens class for Java
      * I've tried to make this class not use any extra features of Java. This
      *  way, it will be easy to translate Turing code to Java. The one major
      *  difference is that it uses a constructor. It also uses the error
      *  stream for errors, since that makes it show in a new window.
      */
    private class Solution{
	int vals[];
	int hashCode=0;
	public Solution(){
	    vals=new int[N];
	    for(int i=0;i<N;++i)
		for(int j=0;j<N;++j)
		    if(occupied[i][j]){
			hashCode=hashCode*N^(vals[i]=j);
			break;
		    }
	}
	public boolean equals(Object o){
	    try{
		final Solution O=(Solution)o; 
		if(o==null||O.vals.length!=vals.length||O.hashCode!=hashCode)
		    return false;
		for(int i=0;i<vals.length;++i)
		    if(O.vals[i]!=vals[i])
			return false;
		return true;
	    }catch(ClassCastException e){
		return false;
	    }
	}
	public int hashCode(){
	    return hashCode;
	}
    }
    int N,W;
    Color A,B;
    Console C;
    final int[] CORRECT={1,1,0,0,2,10,4,40,92,352,724,2680,14200,73712,365596,
	2279184,14772512,95815104,666090624};
    private boolean[] r,c,s,d;
    private boolean[][] occupied;
    private int n=0,soln=0;
    private boolean valid=true;
    HashSet hs=new HashSet();
    public Queens(Console con,int n,int w,Color a,Color b){
	N=n;W=w;A=a;B=b;C=con;
	valid=true;
	r=new boolean[n];
	c=new boolean[n];
	occupied=new boolean[n][n];
	for(int i=0;i<n;++i){
	    r[i]=c[i]=false;
	    for(int j=0;j<n;++j)
		occupied[i][j]=false;
	}
	s=new boolean[n*2-1];
	d=new boolean[n*2-1];
	for(int i=0;i<n*2-1;++i)
	    s[i]=d[i]=false;
    }
    public Queens(Console c){
	this(c,8,80,new Color(1f,.81f,.7f),Color.black);
    }
    public boolean place(int x,int y){
	return x>0&&x<=N&&y>0&&y<=N&&!r[--x]&&!d[x-y+N]&&!c[--y]&&!s[x+y]&&
	    (occupied[x][y]=r[x]=c[y]=s[x+y]=d[x-y+N-1]=true);
    }
    public void remove(int x,int y){
	if(x<1||x>N||y<1||y>N){
	    System.err.println("attempted to remove at "+x+", "+y);
	    valid=false;
	}else{
	    occupied[--x][--y]=r[x]=c[y]=s[x+y]=d[x-y+N-1]=false;
	    --n;
	}
    }
    public int count(){return n;}
    public void display(String title){
	C.println(title);
	for(int j=0;j<N;++j,C.println()){
	    for(int i=0;i<N;++i){
		if(A!=B){
		    C.setColour((i^j&1)==1?A:B);
		    C.setTextBackgroundColour((i^j&1)==1?B:A);
		}
		C.print(occupied[i][j]?"Q ":r[i]||c[j]||s[i+j]||d[i-j+N-1]?
		    ". ":"  ");
	    }
	    if(A!=B){
		C.setColour(Color.black);
		C.setTextBackgroundColour(Color.white);
	    }
	}
    }
    public void check(){
	if(n<N){
	    System.err.println("not enough queens on the board");
	    valid=false;
	    return;
	}
	Solution sol=new Solution();
	if(hs.contains(sol)){
	    System.err.println("duplicate solution encountered");
	    valid=false;
	}else
	    hs.add(sol);
    }
    public void solutions(){
	if(!valid)
	    System.err.println("warning: invalid calls made");
	C.println("found "+soln+(soln==1?" solution":" distinct solutions"));
    }
    public void progress(){
	if(!valid)
	    System.err.println("warning: invalid calls made");
	if(soln==CORRECT[N])
	    C.print("all ");
	int w=(int)((W - 2) * soln / CORRECT[N]+.5);
	C.print(soln+" of "+CORRECT[N]+" solutions, progress:\n[");
	for(int i=w;i-->0;C.print("#"));
	for(int i=W-w-2;i-->0;C.print(" "));
	C.println("]");
    }
    public static void main (String[] args)
    {
	Console c=new Console();
	Queens q=new Queens(c);
	q.place(1,4);q.place(6,5);q.place(7,1);
	c.println(q.place(3,2)?"a queen was placed at (3, 2), which is in line with (6, 5)":"a queen cannot be placed at (3, 2)");
	q.place(4,2);
	q.display("I plan to remove the queen at (4, 2):");
	c.println("queens on the board: "+q.count()+" out of "+q.N);
	q.remove(4,2);
	q.place(4,8);q.place(5,2);q.place(2,7);q.place(3,3);q.place(8,6);
	q.check();
	c.println("queens on the board: "+q.count()+
	    "; changing colour for debugging purposes");
	q.B=new Color(.81f,.545f,.28f);
	q.display("the whole board");
	q.progress();
	q.solutions();
    }
    
}
