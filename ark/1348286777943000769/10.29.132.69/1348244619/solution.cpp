#include<iostream>
using namespace std;

typedef float v4sf __attribute__ ((vector_size (32)));
typedef union {
        v4sf v;
        float f[8];
} f4vec;


#define PI 3.1415926535897932
int main(int argc,char*argv[]){
    f4vec d;
    for (int i=0;i<8;i++)
        d.f[i] = PI*i;
    
	while (true)
        d *= d;
	return 0;
}