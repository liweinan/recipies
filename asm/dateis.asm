	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp2:
	.cfi_def_cfa_offset 16
Ltmp3:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp4:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	leaq	-16(%rbp), %rdi
	movl	$0, -4(%rbp)
	callq	_time
	leaq	-16(%rbp), %rdi
	movq	%rax, -24(%rbp)         ## 8-byte Spill
	callq	_ctime
	leaq	L_.str(%rip), %rdi
	movq	%rax, %rsi
	movb	$0, %al
	callq	_printf
	movl	$0, %edi
	movl	%eax, -28(%rbp)         ## 4-byte Spill
	callq	_exit
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"The date is: %s"


.subsections_via_symbols
