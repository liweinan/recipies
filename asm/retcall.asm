section .bss
	
section .data

section .text
global main 
abc:
	mov eax, 2
	ret
main:
	call abc
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
