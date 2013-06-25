#include<iostream>
#include<cassert>
#include<cstdio>
#include<cmath>
#include<cstring>
#include<string>
#include<stack>
#include<limits>
using namespace std;
void pop(stack<double>&out,stack<pair<int,char> >&op){
	double x;
	switch(op.top().second){
		case'^':x=out.top();out.pop();
			out.top()=pow(out.top(),x);break;
		case'%':x=out.top();out.pop();
			out.top()=fmod(out.top(),x);break;
		case'/':x=out.top();out.pop();
			out.top()/=x;break;
		case'-':x=out.top();out.pop();
			out.top()-=x;break;
		case'*':x=out.top();out.pop();
			out.top()*=x;break;
		case'+':x=out.top();out.pop();
			out.top()+=x;break;
		case's':out.top()=sin(out.top());break;
		case'c':out.top()=cos(out.top());break;
		case't':out.top()=tan(out.top());break;
		case'l':out.top()=log(out.top());break;
		case'e':out.top()=exp(out.top());break;
		case'a':out.top()=fabs(out.top());break;
	}
	op.pop();
}
double eval(string&str,double x){
	int ofs,val;
	stack<double>out;
	stack<pair<int,char> >op;
	for(const char*a=str.c_str();*a;++a){
		int prec=0;
		switch(*a){
			case' ':continue;
			case'^':++prec;
			case'*':case'/':case'%':++prec;
			case'+':case'-':++prec;
				while(!op.empty()&&(*a=='^'?op.top().first>prec:op.top().first>=prec))
					pop(out,op);
			case'(':
				op.push(make_pair(prec,*a));
				break;
			case')':
				while(op.top().second!='(')
					pop(out,op);
				op.pop();
				if(!op.empty()&&op.top().first==-1)
					pop(out,op);
				break;
			case's':case'c':case't':case'l':case'e':case'a':
				op.push(make_pair(-1,*a));
				break;
			case'p':out.push(M_PI);break;
			case'x':out.push(x);break;
			default:
				sscanf(a,"%d%n",&val,&ofs);
				a+=ofs-1;
				out.push(val);
		}
	}
	while(!op.empty())
		pop(out,op);
	return out.top();//should be the only value
}
int main(){
	int r,c,n;
	double xlo,xhi;
	cin>>r>>c>>xlo>>xhi>>n;
	cin.ignore(1,'\n');
	string ex[n];
	for(int i=0;i<n;++i)
		getline(cin,ex[i]);
	double y[n][c],yhi=-numeric_limits<double>::infinity(),ylo=numeric_limits<double>::infinity();
#define CTOX(j) ((double)(j)/(c-1)*(xhi-xlo)+xlo)
	for(int i=0;i<n;++i)
		for(int j=0;j<c;++j){
			y[i][j]=eval(ex[i],CTOX(j));
			if(finite(y[i][j])){
				yhi=max(yhi,y[i][j]);
				ylo=min(ylo,y[i][j]);
			}
		}
	char scrn[r][c];
	for(int i=0;i<r;++i)
		memset(scrn[i],'0',c);
#define RND(x) ((x)==yhi?r-1:(int)(((x)-ylo)/(yhi-ylo)*r))
	for(int i=0;i<n;++i)
		for(int j=0;j<c;++j)
			if(!isnan(y[i][j])){
				int lo=RND(y[i][j]),hi=lo;
				double val=(y[i][j]+(j?y[i][j-1]:eval(ex[i],CTOX(-1))))/2;
				if(!isnan(val)){
					lo=min(lo,RND(val));
					hi=max(hi,RND(val));
				}
				val=(y[i][j]+(j+1<c?y[i][j+1]:eval(ex[i],CTOX(c))))/2;
				if(!isnan(val)){
					lo=min(lo,RND(val));
					hi=max(hi,RND(val));
				}
				for(hi=max((lo=max(lo,0))+1,min(r,hi));lo<hi;++lo)
					if(++scrn[lo][j]>'9')
						scrn[lo][j]='@';
			}
	for(int i=r;i;cout.write(scrn[--i],c)<<'\n');
	return 0;
}
