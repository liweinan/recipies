section .data
	hello: db 'Hello world!',10
	len: equ 13

section .text
global main 
main:
	mov eax, 5
dec_:	dec eax
	jz dec_
	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
