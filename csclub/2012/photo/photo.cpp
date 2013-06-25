#include<iostream>
#include<string>
#include<stdio.h>
#include<algorithm>
using namespace std;
int main(){
	int r,c,b=0,dx,dy=1,n,savel=0,a1,a2,a3,a4,a5;
	struct{int r,c,b,dx,dy;}save[1000];
	cin>>r>>c;
	const int N=r*(dx=c);
	char a[N],a6;
	for(int i=0;i<N;++i)
		scanf(i%c?"%c":"%c%c",&a[i],&a[i]);
#define image(i,j) a[((b+(i)*dx+(j)*dy)%N+N)%N]
	cin>>n;
	while(n--){
		string cmd;
		cin>>cmd;
		if(cmd=="swap"){
			swap(dx,dy);
			swap(r,c);
		}else if(cmd=="fh")
			b-=(dy=-dy)*(c-1);
		else if(cmd=="fv")
			b-=(dx=-dx)*(r-1);
		else if(cmd=="cw"){
			swap(dx,dy);
			swap(r,c);
			b-=(dy=-dy)*(c-1);
		}else if(cmd=="ccw"){
			b-=(dy=-dy)*(c-1);
			swap(dx,dy);
			swap(r,c);
		}else if(cmd=="ofs"){
			cin>>a1>>a2;
			b+=dx*a1+dy*a2;
		}else if(cmd=="lin"){
			cin>>a1>>a2>>a3>>a4>>a5>>a6;--a1;--a2;
			for(int i=0,l=min(a5,N);i<l;++i)
				image(a1+a3*i,a2+a4*i)=a6;
		}else if(cmd=="res"){
			cin>>a1>>a2;
			r=max(1,r+a1);
			c=max(1,c+a2);
		}else if(cmd=="save"){
			save[savel].b=b;
			save[savel].r=r;
			save[savel].c=c;
			save[savel].dx=dx;
			save[savel++].dy=dy;
		}else if(cmd=="load"){
			if(!savel)continue;
			b=save[--savel].b;
			r=save[savel].r;
			c=save[savel].c;
			dx=save[savel].dx;
			dy=save[savel].dy;
		}else if(cmd=="out")
			for(int i=0;i<r;++i)
				for(int j=0;j<c;++j)
					printf(j==c-1?"%c\n":"%c",image(i,j));
		b%=N;dx%=N;dy%=N;
	}
	return 0;
}
