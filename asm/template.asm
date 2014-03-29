section .bss
	
section .data

section .text
global _start 
_start:
	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
