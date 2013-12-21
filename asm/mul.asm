section .data
	hello: db 'Hello world!',10
	len: equ 13

section .text
global main 
main:
	mov ax, 0FFFh
	mov cx, 0FFFh
	mul cx 			; fff x fff = ffe001
;;; ax = e001, dx = ff
	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
