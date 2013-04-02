//#define RUN
extern"C"{
#include<unistd.h>
#include<seccomp.h>
#include<sys/mman.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<stdio.h>
#ifdef RUN
int mymain(int argc,char*argv[]){
	printf("Hello, World!\n");
	return 0;
}
int main(int argc,char *argv[]){
#define mymain main
#else
extern int main(int,char*[]);
extern int _start(int,char*[]);
int _start(int argc,char *argv[]){
#endif
	int ret;
#define add(x,...) &&!(ret=seccomp_rule_add(ctx,SCMP_ACT_ALLOW,SCMP_SYS(x),__VA_ARGS__))
	scmp_filter_ctx ctx;
/* set appropriate functions for 32bit/64bit */
#if defined(__LP64__) || defined(_LP64)
    #define _FSTAT fstat
    #define _MMAP mmap
#else
    #define _FSTAT fstat64
    #define _MMAP mmap2
#endif
	if((ctx=seccomp_init(SCMP_ACT_KILL))
		add(read,1,SCMP_A0(SCMP_CMP_EQ,STDIN_FILENO))
		add(write,1,SCMP_A0(SCMP_CMP_EQ,STDOUT_FILENO))
		add(write,1,SCMP_A0(SCMP_CMP_EQ,STDERR_FILENO))
		add(_FSTAT,1,SCMP_A0(SCMP_CMP_EQ,STDIN_FILENO))
		add(_FSTAT,1,SCMP_A0(SCMP_CMP_EQ,STDOUT_FILENO))
		add(_FSTAT,1,SCMP_A0(SCMP_CMP_EQ,STDERR_FILENO))
		add(_MMAP,4,SCMP_A2(SCMP_CMP_EQ,PROT_READ|PROT_WRITE),SCMP_A3(SCMP_CMP_EQ,MAP_PRIVATE|MAP_ANONYMOUS),SCMP_A4(SCMP_CMP_EQ,-1),SCMP_A5(SCMP_CMP_EQ,(off_t)0))
		add(munmap,0)
		add(time,0)
		add(times,0)
		add(exit_group,0)
		//&&(ret=seccomp_load(ctx))>=0)
		&&1)
			return main(argc,argv);
	seccomp_release(ctx);
	fprintf(stderr,"seccomp error %d\n",ret);
	return-ret;
}
}
