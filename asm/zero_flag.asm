section .data
	hello: db 'Hello, world!',10
	len: equ 14

section .text
global main 
main:
	mov eax, 0 
	inc eax
	dec eax ; set zero_flag

	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
