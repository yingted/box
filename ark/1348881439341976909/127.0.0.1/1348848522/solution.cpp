#include<iostream>//needed for min
#include<stdio.h>
using namespace std;
int main(){
    for(int t=10,n;t--;){
		scanf("%d",&n);
		unsigned int a[n][n],b[n+1];
		b[0]=0;
		for(int i=0;i<n;++i){
			scanf("%d",&a[i][i]);
			b[i+1]=b[i]+a[i][i];
		}
		for(int i=0;i<n;++i){
			a[i][i]=0;
			for(int j=0;j<i;++j)
				a[j][i]=1<<29;
		}
		for(int d=1;d<n;++d)
			for(int i=0;i+d<n;++i){
				a[i][i+d]=~(1<<31);
				for(int j=i,l=b[i+d+1]-b[i];j<i+d;++j)
					a[i][i+d]=min(a[i][i+d],a[i][j]+a[j+1][i+d]+l);
			}
		printf("%d\n",a[0][n-1]);
	}
	return 0;
}
