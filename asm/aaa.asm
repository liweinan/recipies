section .bss
	
section .data

section .text
global main 
main:
	xor eax, eax
	mov al, '8' ; 0011 1000 high nybble(0011) is ignored by aaa
	add al, '2' ; 0110 0010 high nybble(0110) is ignored by aaa
	aaa ; ah = 0000 0001 (1) al = 0000 0000 (0)
	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
