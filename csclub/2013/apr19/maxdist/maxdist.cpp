#include<stdio.h>
#include<algorithm>
using namespace std;
int main(){
	int n,d;
	scanf("%d%d",&n,&d);
	int a[n+1];
	for(int i=0;i<n;scanf("%d",&a[i++]));
	a[n]=a[n-1];
	int best=0;
	for(int start=0;start<n;++start){
		int m=a[start],M=a[start],end=start;
		for(;M-m<=d&&end<=n;++end){
			m=min(m,a[end]);
			M=max(M,a[end]);
		}
		best=max(best,end-1-start);
	}
	printf("%d\n",best);
	return 0;
}
