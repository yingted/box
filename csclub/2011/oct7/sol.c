#include <stdio.h>
#include <stdlib.h>
int main(){
	for(;;){
		int n,m,*ax,*ay;
		scanf("%i%i",&n,&m);
		if(!n)break;
		ax=(int*)malloc((n+1)*sizeof(int));
		ay=(int*)malloc((n+1)*sizeof(int));
		for(int i=0;i<n;++i)
			scanf("%i%i",&ax[i],&ay[i]);
		ax[n]=ax[0];
		ay[n]=ay[0];
		while(m-->0){
			int px,py,c=0;
			scanf("%i%i",&px,&py);
			for(int i=0;i<n;++i)
				if(ay[i]>py){
					if(ay[i+1]<=py&&(ax[i+1]-px)*(ay[i]-py)>(ay[i+1]-py)*(ax[i]-px))
						--c;
				}else if(ay[i+1]>py&&(ax[i+1]-px)*(ay[i]-py)<(ay[i+1]-py)*(ax[i]-px))
					++c;
			printf("%i\n",c);
		};
		free(ax);
		free(ay);
	};
	return 0;
};
