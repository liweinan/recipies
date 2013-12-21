section .bss
	BUFFLEN equ 16
Buff:	resb BUFFLEN
	
section .data
HexStr:	db " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00",10
	HEXLEN equ $-HexStr
Digits:	 db "0123456789ABCDEF"
	
section .text
global main 
main:
	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
