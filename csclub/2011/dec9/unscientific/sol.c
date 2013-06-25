#include<stdio.h>
int main(){
	const static int fact[]={1,1,2,6,4},pow2[]={6,2,4,8};
	for(;;){
		int n,zeroes=0,last;
		scanf("%d",&n);
		if(n<0)return 0;
		for(last=fact[n%5];n/=5;zeroes+=n)
			last=last*fact[n%5]*pow2[n%4]%10;
		printf("%du%d\n",last,zeroes);
	}
}
