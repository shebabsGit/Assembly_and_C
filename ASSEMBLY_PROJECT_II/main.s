# Author: Shehab Ahmed
# Student ID: C00295178
# Date: 01/05/2025
# Description: Significant changes and considerations during conversion process


	.text
	.globl	add
	.type	add, @function

# Align 8 = \n

# Add 2 numbers
add:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc

.LFE6:
	.size	add, .-add
	.section	.rodata
.LC0:
	.string	"%s"
.LC1:
	.string	"%d"
	.align 8
.LC2:
	.string	"Invalid input. Please enter a number between 0 and 255."
	.align 8
.LC3:
	.string	"Too many invalid attempts. Exiting program."
	
	
	.text
	.globl	validateNum
	.type	validateNum, @function

# Validate user inputted numbers
validateNum:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -12(%rbp)
	jmp	.L4
.L7:
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-16(%rbp), %eax
	testl	%eax, %eax
	js	.L5
	movl	-16(%rbp), %eax
	cmpl	$255, %eax
	jg	.L5
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L8
	jmp	.L9
.L5:
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	addl	$1, -12(%rbp)
.L4:
	cmpl	$4, -12(%rbp)
	jle	.L7
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %edi
	call	exit@PLT
.L9:
	call	__stack_chk_fail@PLT
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	validateNum, .-validateNum
	.section	.rodata
	.align 8


.LC4:
	.string	"------------------------------------------------"
	.align 8
.LC5:
	.string	"Enter first number (0 - 255): "
	.align 8
.LC6:
	.string	"Enter second number (0 - 255): "
.LC7:
	.string	"The sum is: %d\n"
.LC8:
	.string	"Final sum is: %d\n"
	
	
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	$0, -20(%rbp)
	movl	$1, -16(%rbp)
	jmp	.L11
.L12:
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	validateNum # Validates numbers
	movl	%eax, -12(%rbp)
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	call	validateNum # Validate again
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %edx
	movl	-12(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	add			# Add validated numbers in another subroutine
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT  # Print message
	movl	-4(%rbp), %eax
	addl	%eax, -20(%rbp)
	addl	$1, -16(%rbp)
.L11:
	cmpl	$3, -16(%rbp)
	jle	.L12
	movl	-20(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
