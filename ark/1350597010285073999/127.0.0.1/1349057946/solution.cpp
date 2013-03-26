#include<iostream>
#include<stdio.h>
using namespace std;
int main(){
	for(int t=10,n;t--;){
		scanf("%d",&n);
		unsigned int a[n],b[n];
		for(int i=0;i<n;++i){
			scanf("%d",&a[i]);
			b[i]=i+1;
		}
		n=b[n-1]=0;
		while(b[0]){
			unsigned int m=0,ms=-1;
			for(int c=0;b[c];c=b[c]){
				const unsigned int s=a[c]+a[b[c]];
				if(s<ms){
					ms=s;
					m=c;
				}
			}
			b[m]=b[b[m]];
			n+=a[m]=ms;
		}
		printf("%d\n",n);
	}
	return 0;
}
