                                       #include \
                                       <iostream>
                                       #define AV
                                       #define  \
                                       B(a,b)a##b
                                       #define  D
                                       #define  \
                                       C(a) D a D
                                       using B(n,
                                       amespace)D
                                       std;C(int)
                                       l(int n) {
                                       static  AV
                                       const  int
                                       f[]={1,1,D
                                       2,6,4}; AV
                                       return(n<5
                                       ?f[n]:( AV
                                       (2<<((n/5-
                                       1)&3))*l(n
                                       /5)*f[n%5]
                                       )%10);C(D)
                                       }int main(
                                       ){int n;AV
                                       while (cin
                                       >>n&& n>=0
                                       ){int z=0;
                                       for(int i=
                                       n/5;i>0;AV




                                       z+=i,i/=5)
                                       ;cout<< AV
                                       l(n)<<'u'D
                                       <<z<<endl;
                                       }return 0;
                                       C(C(C(})))
