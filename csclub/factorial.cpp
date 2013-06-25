#include<iostream>
using namespace std;
int main(){
	cout<<"calculate n!"<<endl<<"n = ";
	int n;
	cin>>n;
#define dofact(t) {\
		t x=1;\
		for(int i=1;i<=n;++i)\
			x*=i;\
		cout<<"n! = "<<x<<endl;\
	}
	if(n>20)dofact(double)
	else dofact(long long)
	return 0;
}
