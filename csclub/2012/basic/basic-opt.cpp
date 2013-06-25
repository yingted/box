#include<iostream>//needed for min
#include<stdio.h>
using namespace std;
int main(){
	for(int t=10,n;t--;){
		scanf("%d",&n);
		unsigned int a[n][n],b[n+1];
		b[0]=0;
		for(int i=0;i<n;++i){
			scanf("%d",&b[i+1]);
			b[i+1]+=b[i];
			a[i][i]=0;
		}
		for(int d=1;d<n;++d)
			for(int i=0;i+d<n;++i){
				unsigned int m=-1,*ai=a[i];
				for(int j=i;j<i+d;++j)
					m=min(m,ai[j]+a[j+1][i+d]);
				a[i][i+d]=m+b[i+d+1]-b[i];
			}
		printf("%d\n",a[0][n-1]);
	}
	return 0;
}
