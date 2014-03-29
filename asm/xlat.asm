section .bss
	
section .data
	UpCase: db 'a', 'b', 'c'
section .text
global main 
main:
	mov ebx, UpCase
	mov al, 2
	xlat
	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
