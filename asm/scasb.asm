section .bss
	
section .data
	Str: db 00h,01h,02h,03h
	LEN equ $-Str
section .text
global _start 
_start:
	xor eax, eax
	mov ecx, LEN
	mov al, 1
	mov edi, Str
	repne scasb		
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
