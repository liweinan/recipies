[section .bss]
	
[section .data]

[section .text]
global _start 
_start:
;;; xor = 0x31 eax, eax = 0c
;;; 31 c0
;;; gdb> x $eip
;;; => 0x8048060 <_start>:	xor    %eax,%eax
;;; gdb> x /x  $eip
;;; 0x8048060 <_start>:	0xfdebc031
	xor eax, eax
	jmp $-2
	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
