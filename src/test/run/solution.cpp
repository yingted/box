#include<iostream>
#include<stdlib.h>
using namespace std;
int main(){
cout<<42;return 0;
	int x,*b=(int*)malloc(300000000*sizeof(int));
	cout<<"b="<<b<<endl;
	cin>>x;
	cout<<"Hello, World!"<<endl;
	cout<<x<<endl;
	cout.flush();
	//fork();
	cout<<"Hello to you too!"<<endl;
	return 0;
}
