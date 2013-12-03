.section .data
output:
	.ascii "The processor Vendor ID is 'xxxxyyyyzzzz'\n"
.section .text
.globl _start
_start:
	movl $0, %eax
	cpuid
	movl $output, %edi
#	movl %ebx, 28(%edi)
	movl %edx, 32(%edi)
#	movl %ecx, 36(%edi)
	movl $4, %eax # system call val
	movl $1, %ebx # file descriptor
	movl $output, %ecx # start of string
	movl $42, %edx # length of the string
	int $0x80
	movl $1, %eax
	movl $0, %ebx
	int $0x80	
	
	
