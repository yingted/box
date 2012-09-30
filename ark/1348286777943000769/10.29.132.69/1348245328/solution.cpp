#include<iostream>
using namespace std;

typedef float v4sf __attribute__ ((vector_size (64)));
typedef union {
        v4sf v;
        float f[16];
} f4vec;

#define E 2.718281828
#define PI 3.1415926535897932
int main(int argc,char*argv[]){
    f4vec d;
    for (int i=0;i<16;i++)
        d.f[i] = PI+E*i+1;
    
	while (true) {
        d.v *= d.v;
        d.v += d.v;
        d.v /= d.v;
	}
	return 0;
}