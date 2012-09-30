#include<iostream>
using namespace std;

typedef float v4sf __attribute__ ((vector_size (64)));
typedef union {
    v4sf v;
    float f[16];} f4vec;
int main(int argc,char*argv[]){

    f4vec d;
    for (int i=0;i<16;i++)
        d.f[i] = 2.1718183 + 4.8*i;

        
	while (true) {
        d.v *= d.v;
        d.v += d.v;
        d.v /= d.v;
	}
	return 0;
}