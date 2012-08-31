#include<string.h>
#include<sys/types.h>
#include<unistd.h>
#include<stdlib.h>
#include<stdio.h>
#define err(msg) do{perror(msg);exit(-1);}while(0)
int main(int argc,char*argv[]){
	if(argc<3)
		exit(-1);
	const int id=atoi(argv[1]);
	//fprintf(stderr,"dropping to %d\n",id);
	if(!getuid())
		if(setregid(id,id)||setregid(id,id))
			err("setgid");
		else if(setreuid(id,id)||setreuid(id,id))
			err("setuid");
	//fprintf(stderr,"uid %d gid %d\n",getuid(),getgid());
	if(setuid(0)>=0)
		err("setuid(0)");
	execvp(argv[2],argv+2);
	err("execvp");
}
