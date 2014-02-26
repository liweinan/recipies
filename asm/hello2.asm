section .data
	hello: db 'Hello world!',10
	len: equ 13

section .text
global _start
_start:
	mov eax, 4 ; sys_write
	mov ebx, 1 ; fd
	mov ecx, hello
	mov edx, len
	int 80h
	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
