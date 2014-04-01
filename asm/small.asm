; http://stackoverflow.com/questions/2720161/relocation-truncated-to-fit-error-in-nasm-x86-64
section .bss
	
section .data
	var1 equ 1
section .text
global _start 
_start:
	mov ax, var1
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
