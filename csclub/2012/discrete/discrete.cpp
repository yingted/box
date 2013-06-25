#include<iostream>
#include<stdlib.h>//abs(x) function
using namespace std;
int main(){
#define int long long
	int t,k;
	cin>>t>>k;
	int v[t],s=0,M[t+1];
	for(int i=0;i<t;s+=v[i++]){
		cin>>v[i];
		v[i]=(v[i]+k-s%k)%k;
	}
	for(int i=M[0]=0;i<t;M[++i]=1<<30);
	for(int i=s=0;i<t;++i){
		const int a=(v[i]-(i?v[i-1]:0)+k)%k;
		for(int j=t;j>=0;--j)
			M[j]=min(M[j]+abs((s-j*k)*a),j?M[j-1]+abs((s-(j-1)*k)*(k-a)):1<<30);
		s+=a;
	}
	s=1<<30;
	for(int i=0;i<=t;s=min(s,M[i++]));
	cout<<s<<endl;
	return 0;
}
