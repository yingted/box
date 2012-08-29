#include<iostream>
//#include<unistd.h>
//#include<sys/prctl.h>
using namespace std;
//extern "C"int niam(){}
int main(){
	return 0;
	//cin.peek();
	//cout.put('\n').flush();
	int x;
	cin>>x;
	cout<<"Hello, World!"<<endl;
	cout<<x<<endl;
	cout.flush();
	fork();
	cout<<"Hello to you too!"<<endl;
	return 0;
}
