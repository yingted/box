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
	subl	$396, %esp
	.cfi_def_cfa_offset 400
	movl	%esi, 384(%esp)
	movl	400(%esp), %eax
	movl	404(%esp), %esi
	.cfi_offset 6, -16
	movl	$0, (%esp)
	movl	%ebp, 392(%esp)
	movl	%ebx, 380(%esp)
	movl	%edi, 388(%esp)
	movl	%eax, 120(%esp)
	movl	%esi, 124(%esp)
	.cfi_offset 7, -12
	.cfi_offset 3, -20
	.cfi_offset 5, -8
	call	seccomp_init
	testl	%eax, %eax
	movl	%eax, %ebp
	je	.L2
	xorl	%eax, %eax
.L3:
	movl	$0, 128(%esp,%eax)
	addl	$4, %eax
	cmpl	$24, %eax
	jb	.L3
	movl	128(%esp), %eax
	movl	$4, 132(%esp)
	movl	$4, 20(%esp)
	movl	$1, 12(%esp)
	movl	%eax, 16(%esp)
	movl	136(%esp), %eax
	movl	$3, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebp, (%esp)
	movl	%eax, 24(%esp)
	movl	140(%esp), %eax
	movl	%eax, 28(%esp)
	movl	144(%esp), %eax
	movl	%eax, 32(%esp)
	movl	148(%esp), %eax
	movl	%eax, 36(%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %ebx
	je	.L23
	.p2align 4,,7
	.p2align 3
.L2:
	movl	%ebp, (%esp)
	call	seccomp_release
	movl	stderr, %eax
	movl	%ebx, 8(%esp)
	movl	$.LC0, 4(%esp)
	movl	%eax, (%esp)
	call	fprintf
	movl	%ebx, %eax
	movl	384(%esp), %esi
	negl	%eax
	movl	380(%esp), %ebx
	movl	388(%esp), %edi
	movl	392(%esp), %ebp
	addl	$396, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	.cfi_restore 5
	.cfi_restore 7
	.cfi_restore 6
	.cfi_restore 3
	ret
	.p2align 4,,7
	.p2align 3
.L23:
	.cfi_restore_state
	xorl	%eax, %eax
.L5:
	movl	$0, 152(%esp,%eax)
	addl	$4, %eax
	cmpl	$24, %eax
	jb	.L5
	movl	152(%esp), %eax
	movl	$0, 164(%esp)
	movl	$4, 156(%esp)
	movl	$1, 160(%esp)
	movl	%eax, 16(%esp)
	movl	164(%esp), %eax
	movl	$4, 20(%esp)
	movl	$1, 24(%esp)
	movl	$1, 12(%esp)
	movl	%eax, 28(%esp)
	movl	168(%esp), %eax
	movl	$4, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebp, (%esp)
	movl	%eax, 32(%esp)
	movl	172(%esp), %eax
	movl	%eax, 36(%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %ebx
	jne	.L2
	xorl	%eax, %eax
.L7:
	movl	$0, 176(%esp,%eax)
	addl	$4, %eax
	cmpl	$24, %eax
	jb	.L7
	movl	176(%esp), %eax
	movl	$0, 188(%esp)
	movl	$4, 180(%esp)
	movl	$2, 184(%esp)
	movl	%eax, 16(%esp)
	movl	188(%esp), %eax
	movl	$4, 20(%esp)
	movl	$2, 24(%esp)
	movl	$1, 12(%esp)
	movl	%eax, 28(%esp)
	movl	192(%esp), %eax
	movl	$4, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebp, (%esp)
	movl	%eax, 32(%esp)
	movl	196(%esp), %eax
	movl	%eax, 36(%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %ebx
	jne	.L2
	xorl	%eax, %eax
.L9:
	movl	$0, 200(%esp,%eax)
	addl	$4, %eax
	cmpl	$24, %eax
	jb	.L9
	movl	200(%esp), %eax
	movl	$4, 204(%esp)
	movl	$4, 20(%esp)
	movl	$1, 12(%esp)
	movl	%eax, 16(%esp)
	movl	208(%esp), %eax
	movl	$197, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebp, (%esp)
	movl	%eax, 24(%esp)
	movl	212(%esp), %eax
	movl	%eax, 28(%esp)
	movl	216(%esp), %eax
	movl	%eax, 32(%esp)
	movl	220(%esp), %eax
	movl	%eax, 36(%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %ebx
	jne	.L2
	xorl	%eax, %eax
.L11:
	movl	$0, 224(%esp,%eax)
	addl	$4, %eax
	cmpl	$24, %eax
	jb	.L11
	movl	224(%esp), %eax
	movl	$0, 236(%esp)
	movl	$4, 228(%esp)
	movl	$1, 232(%esp)
	movl	%eax, 16(%esp)
	movl	236(%esp), %eax
	movl	$4, 20(%esp)
	movl	$1, 24(%esp)
	movl	$1, 12(%esp)
	movl	%eax, 28(%esp)
	movl	240(%esp), %eax
	movl	$197, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebp, (%esp)
	movl	%eax, 32(%esp)
	movl	244(%esp), %eax
	movl	%eax, 36(%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %ebx
	jne	.L2
	xorl	%eax, %eax
.L13:
	movl	$0, 248(%esp,%eax)
	addl	$4, %eax
	cmpl	$24, %eax
	jb	.L13
	movl	248(%esp), %eax
	movl	$0, 260(%esp)
	movl	$4, 252(%esp)
	movl	$2, 256(%esp)
	movl	%eax, 16(%esp)
	movl	260(%esp), %eax
	movl	$4, 20(%esp)
	movl	$2, 24(%esp)
	movl	$1, 12(%esp)
	movl	%eax, 28(%esp)
	movl	264(%esp), %eax
	movl	$197, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebp, (%esp)
	movl	%eax, 32(%esp)
	movl	268(%esp), %eax
	movl	%eax, 36(%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %ebx
	jne	.L2
	leal	344(%esp), %edx
	movl	$6, %ecx
	movl	%edx, %edi
	rep stosl
	leal	320(%esp), %edx
	movl	%edx, %edi
	leal	296(%esp), %edx
	movl	$5, 344(%esp)
	movl	$4, 348(%esp)
	movb	$6, %cl
	rep stosl
	movl	%edx, %edi
	leal	272(%esp), %edx
	movl	$4, 320(%esp)
	movl	$4, 324(%esp)
	movl	$-1, 328(%esp)
	movl	$-1, 332(%esp)
	movb	$6, %cl
	rep stosl
	movl	%edx, %edi
	leal	344(%esp), %edx
	movl	$3, 296(%esp)
	movl	%edx, %esi
	movl	$4, 300(%esp)
	leal	320(%esp), %edx
	movl	$34, 304(%esp)
	movl	$0, 308(%esp)
	movb	$6, %cl
	rep stosl
	leal	88(%esp), %eax
	movl	$2, 272(%esp)
	movl	%eax, %edi
	movl	$4, 276(%esp)
	leal	64(%esp), %eax
	movl	$3, 280(%esp)
	movl	$0, 284(%esp)
	movb	$6, %cl
	rep movsl
	movl	%eax, %edi
	movl	%edx, %esi
	leal	40(%esp), %eax
	leal	296(%esp), %edx
	movb	$6, %cl
	rep movsl
	movl	%eax, %edi
	movl	%edx, %esi
	leal	16(%esp), %eax
	leal	272(%esp), %edx
	movb	$6, %cl
	rep movsl
	movl	%eax, %edi
	movl	%edx, %esi
	movb	$6, %cl
	rep movsl
	movl	$1, 12(%esp)
	movl	$192, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebp, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %ebx
	jne	.L2
	movl	$0, 12(%esp)
	movl	$252, 8(%esp)
	movl	$2147418112, 4(%esp)
	movl	%ebp, (%esp)
	call	seccomp_rule_add_exact
	testl	%eax, %eax
	movl	%eax, %ebx
	jne	.L2
	movl	%ebp, (%esp)
	call	seccomp_load
	testl	%eax, %eax
	movl	%eax, %ebx
	js	.L2
	movl	120(%esp), %esi
	movl	124(%esp), %eax
	movl	380(%esp), %ebx
	movl	388(%esp), %edi
	movl	%esi, 400(%esp)
	movl	392(%esp), %ebp
	movl	384(%esp), %esi
	movl	%eax, 404(%esp)
	addl	$396, %esp
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
