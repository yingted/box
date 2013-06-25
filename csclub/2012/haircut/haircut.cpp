#include<iostream>
#include<stdlib.h>//the llabs function
using namespace std;
int main(){
	int n;
	unsigned long long ax,ay,s=0,px,py,x,y;
	cin>>n>>ax>>ay;
	for(px=ax,py=ay;--n;px=x,py=y){
		cin>>x>>y;
		s+=x*py-y*px;
	}
	cout<<(s=llabs(s+y*ax-x*ay))/2;//round down
	if(s&1)cout<<".5";//whether it's odd
	cout<<endl;//ending newline
	return 0;
}
