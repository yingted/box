/**
 * Seccomp Library test program
 *
 * Copyright (c) 2012 Red Hat <pmoore@redhat.com>
 * Author: Paul Moore <pmoore@redhat.com>
 */

/*
 * This library is free software; you can redistribute it and/or modify it
 * under the terms of version 2.1 of the GNU Lesser General Public License as
 * published by the Free Software Foundation.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
 * for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library; if not, see <http://www.gnu.org/licenses>.
 */
//#define RUN
extern"C"{
#include<unistd.h>
#include<seccomp.h>
#include<stdio.h>
extern int main(int,char*[]);
extern int _start(int,char*[]);
int _start(int argc,char *argv[]){
	int ret;
#ifndef RUN
#define add(x,...) &&!(ret=seccomp_rule_add_exact(ctx,SCMP_ACT_ALLOW,SCMP_SYS(x),__VA_ARGS__))
	scmp_filter_ctx ctx;
	if((ctx=seccomp_init(SCMP_ACT_KILL))
//		add(read,1,SCMP_A0(SCMP_CMP_EQ,STDIN_FILENO))
//		add(write,1,SCMP_A0(SCMP_CMP_EQ,STDOUT_FILENO))
//		add(write,1,SCMP_A0(SCMP_CMP_EQ,STDERR_FILENO))
		add(close,0)
		add(clone,0)
		add(access,0)
		add(brk,0)
		add(execve,0)

		add(brk,0)
		add(exit_group,0)
		add(fstat64,0)
		add(mprotect,0)
		add(munmap,0)
		add(mmap2,0)
		add(open,0)
		add(read,0)
		add(write,0)
		add(set_thread_area,0)

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
