	.file	"box.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"error %d\n"
	.text
	.p2align 4,,15
	.globl	_start
	.type	_start, @function
_start:
.LFB16:
	.cfi_startproc
	subl	$44, %esp
	.cfi_def_cfa_offset 48
	movl	$0, (%esp)
	movl	%ebx, 28(%esp)
	movl	%edi, 36(%esp)
	movl	48(%esp), %edi
	.cfi_offset 7, -12
	.cfi_offset 3, -20
	movl	%ebp, 40(%esp)
	movl	52(%esp), %ebp
	.cfi_offset 5, -8
	movl	%esi, 32(%esp)
	.cfi_offset 6, -16
	call	seccomp_init
	testl	%eax, %eax
	movl	%eax, %ebx
	je	.L2
	movl	$0, 12(%esp)
	movl	$6, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%eax, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %esi
	je	.L5
.L2:
	movl	%ebx, (%esp)
	call	seccomp_release
	movl	stderr, %eax
	movl	%esi, 8(%esp)
	movl	$.LC0, 4(%esp)
	movl	%eax, (%esp)
	call	fprintf
	movl	%esi, %eax
	movl	28(%esp), %ebx
	negl	%eax
	movl	32(%esp), %esi
	movl	36(%esp), %edi
	movl	40(%esp), %ebp
	addl	$44, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	.cfi_restore 5
	.cfi_restore 7
	.cfi_restore 6
	.cfi_restore 3
	ret
	.p2align 4,,7
	.p2align 3
.L5:
	.cfi_restore_state
	movl	$0, 12(%esp)
	movl	$45, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %esi
	jne	.L2
	movl	$0, 12(%esp)
	movl	$252, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %esi
	jne	.L2
	movl	$0, 12(%esp)
	movl	$197, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %esi
	jne	.L2
	movl	$0, 12(%esp)
	movl	$125, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %esi
	jne	.L2
	movl	$0, 12(%esp)
	movl	$91, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %esi
	jne	.L2
	movl	$0, 12(%esp)
	movl	$192, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %esi
	jne	.L2
	movl	$0, 12(%esp)
	movl	$5, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %esi
	jne	.L2
	movl	$0, 12(%esp)
	movl	$3, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %esi
	jne	.L2
	movl	$0, 12(%esp)
	movl	$4, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %esi
	jne	.L2
	movl	$0, 12(%esp)
	movl	$243, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %esi
	jne	.L2
	movl	%ebx, (%esp)
	call	seccomp_load
	testl	%eax, %eax
	movl	%eax, %esi
	js	.L2
	movl	%ebp, 52(%esp)
	movl	28(%esp), %ebx
	movl	%edi, 48(%esp)
	movl	32(%esp), %esi
	movl	36(%esp), %edi
	movl	40(%esp), %ebp
	addl	$44, %esp
	.cfi_def_cfa_offset 4
	.cfi_restore 5
	.cfi_restore 7
	.cfi_restore 6
	.cfi_restore 3
	jmp	main
	.cfi_endproc
.LFE16:
	.size	_start, .-_start
	.ident	"GCC: (GNU) 4.6.3 20120306 (Red Hat 4.6.3-2)"
	.section	.note.GNU-stack,"",@progbits
