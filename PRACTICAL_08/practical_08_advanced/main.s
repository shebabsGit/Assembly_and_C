	.file	"main.c"
	.text
	.section	.rodata
.LC0:
	.string	"Array......."
.LC1:
	.string	"STARTS:"
.LC2:
	.string	"%d\n"
.LC3:
	.string	"ENDS:"
.LC4:
	.string	"\n2D Array........."
.LC5:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$10, -60(%rbp)
	movl	$20, -56(%rbp)
	movl	$30, -52(%rbp)
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	movl	$0, -72(%rbp)
	jmp	.L2
.L3:
	movl	-72(%rbp), %eax
	cltq
	movl	-60(%rbp,%rax,4), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -72(%rbp)
.L2:
	cmpl	$2, -72(%rbp)
	jle	.L3
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	movl	$1, -48(%rbp)
	movl	$0, -44(%rbp)
	movl	$0, -40(%rbp)
	movl	$0, -36(%rbp)
	movl	$1, -32(%rbp)
	movl	$0, -28(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	movl	$1, -16(%rbp)
	leaq	.LC4(%rip), %rdi
	call	puts@PLT
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	movl	$0, -68(%rbp)
	jmp	.L4
.L7:
	movl	$0, -64(%rbp)
	jmp	.L5
.L6:
	movl	-64(%rbp), %eax
	movslq	%eax, %rcx
	movl	-68(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	movl	-48(%rbp,%rax,4), %eax
	movl	%eax, %esi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -64(%rbp)
.L5:
	cmpl	$2, -64(%rbp)
	jle	.L6
	movl	$10, %edi
	call	putchar@PLT
	addl	$1, -68(%rbp)
.L4:
	cmpl	$2, -68(%rbp)
	jle	.L7
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
