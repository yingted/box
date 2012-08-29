	.file	"box.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"it works!\n"
	.text
	.p2align 4,,15
	.globl	_start
	.type	_start, @function
_start:
.LFB16:
	.cfi_startproc
	subl	$28, %esp
	.cfi_def_cfa_offset 32
	movl	$0, (%esp)
	movl	%ebx, 16(%esp)
	movl	%esi, 20(%esp)
	movl	32(%esp), %esi
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	movl	%edi, 24(%esp)
	movl	36(%esp), %edi
	.cfi_offset 7, -8
	call	seccomp_init
	testl	%eax, %eax
	movl	%eax, %ebx
	je	.L3
	movl	$0, 12(%esp)
	movl	$6, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%eax, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	je	.L5
.L3:
	movl	%edi, 36(%esp)
	movl	16(%esp), %ebx
	movl	%esi, 32(%esp)
	movl	24(%esp), %edi
	movl	20(%esp), %esi
	addl	$28, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	.cfi_restore 7
	.cfi_restore 6
	.cfi_restore 3
	jmp	main
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
	jne	.L3
	movl	$0, 12(%esp)
	movl	$252, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	jne	.L3
	movl	$0, 12(%esp)
	movl	$197, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	jne	.L3
	movl	$0, 12(%esp)
	movl	$125, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	jne	.L3
	movl	$0, 12(%esp)
	movl	$91, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	jne	.L3
	movl	$0, 12(%esp)
	movl	$192, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	jne	.L3
	movl	$0, 12(%esp)
	movl	$5, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	jne	.L3
	movl	$0, 12(%esp)
	movl	$3, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	jne	.L3
	movl	$0, 12(%esp)
	movl	$4, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	jne	.L3
	movl	$0, 12(%esp)
	movl	$243, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebx, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	jne	.L3
	movl	%ebx, (%esp)
	call	seccomp_load
	testl	%eax, %eax
	js	.L3
	movl	stderr, %eax
	movl	$10, 8(%esp)
	movl	$1, 4(%esp)
	movl	$.LC0, (%esp)
	movl	%eax, 12(%esp)
	call	fwrite
	jmp	.L3
	.cfi_endproc
.LFE16:
	.size	_start, .-_start
	.ident	"GCC: (GNU) 4.6.3 20120306 (Red Hat 4.6.3-2)"
	.section	.note.GNU-stack,"",@progbits
