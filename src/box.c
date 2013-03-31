//#define RUN
extern"C"{
#include<unistd.h>
#include<seccomp.h>
#include<sys/mman.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<stdio.h>
extern int main(int,char*[]);
extern int _start(int,char*[]);
int _start(int argc,char *argv[]){
	int ret;
#ifndef RUN
#define add(x,...) &&!(ret=seccomp_rule_add_exact(ctx,SCMP_ACT_ALLOW,SCMP_SYS(x),__VA_ARGS__))
	scmp_filter_ctx ctx;
	int fd1 = open("/dev/random", 0), fd2 = open("/dev/urandom", 0);
	if((ctx=seccomp_init(SCMP_ACT_KILL))
		add(read,1,SCMP_A0(SCMP_CMP_EQ,STDIN_FILENO))
		add(read,1,SCMP_A0(SCMP_CMP_EQ,fd1))
		add(read,1,SCMP_A0(SCMP_CMP_EQ,fd2))
		add(write,1,SCMP_A0(SCMP_CMP_EQ,STDOUT_FILENO))
		add(write,1,SCMP_A0(SCMP_CMP_EQ,STDERR_FILENO))
		add(fstat64,1,SCMP_A0(SCMP_CMP_EQ,STDIN_FILENO))
		add(fstat64,1,SCMP_A0(SCMP_CMP_EQ,STDOUT_FILENO))
		add(fstat64,1,SCMP_A0(SCMP_CMP_EQ,STDERR_FILENO))
		add(mmap2,4,SCMP_A2(SCMP_CMP_EQ,PROT_READ|PROT_WRITE),SCMP_A3(SCMP_CMP_EQ,MAP_PRIVATE|MAP_ANONYMOUS),SCMP_A4(SCMP_CMP_EQ,-1),SCMP_A5(SCMP_CMP_EQ,(off_t)0))
		add(exit_group,0)
		&&(ret=seccomp_load(ctx))>=0)
#endif
			return main(argc,argv);
#ifndef RUN
	seccomp_release(ctx);
	fprintf(stderr,"error %d\n",ret);
	return-ret;
#endif
}
}
