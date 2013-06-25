#include<stdio.h>
#include<stdlib.h>
#include<complex.h>
#include<math.h>
#include<stdbool.h>
void fft(complex*e,complex*scratch,complex*x,complex*X,long N){
 if(N==1){
  *X=*x;
  return;
 }
 int k,m,n,skip;
 bool even=N&0x55555555;
 complex*src=x,*a,*b,*dst;
 for(n=1;n<N;n<<=1){
  b=(a=dst=even?scratch:X)+(N>>1);
  skip=N/(n<<1);
  for(k=0;k<n;++k){
   complex t=e[k*skip];
   for(m=0;m<skip;++m){
    complex D=t*src[skip];
    *(a++)=*src+D;
    *(b++)=*(src++)-D;
   }
   src+=skip;
  }
  src=dst;
  even^=1;
 }
}
int main(){
 int i,m,n,N;
 scanf("%d%d",&m,&n);
 N=1<<32-__builtin_clz(m+n-1);
#define z(x) *x=(typeof(x))malloc(N*sizeof(typeof(*x)))
 complex z(a),z(b),z(c),z(d),z(e);
 for(i=0;i<N;++i)
  e[i]=cexp(-2*I*i*M_PI/N);
 for(i=0;i<N;++i)
  a[i]=b[i]=0;
 while(m--)
  scanf("%lg",&a[m]);
 while(n--)
  scanf("%lg",&b[n]);
 fft(e,d,a,c,N);
 fft(e,d,b,a,N);
 for(i=0;i<N;++i)
  a[i]*=c[i]/N;
 fft(e,d,a,c,N);
 long z(x);
 for(i=0;i<N;++i)
  x[i]=(int)(c[(N-i)%N]+.5);
 for(i=1;i<N;++i){
  x[i]+=x[i-1]/10;
  x[i-1]%=10;
 }
 for(i=0;N--;)
  if(i|=x[N])
   printf("%ld",x[N]);
 puts("");
 return 0;
}
