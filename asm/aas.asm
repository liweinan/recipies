section .bss
	
section .data

section .text
global main 
main:
	xor eax, eax
	mov al, '9'
	sub al, '3'
	aas
	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
