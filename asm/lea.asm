section .bss
	
section .data

section .text
global main 
main:
	mov eax, 1
	xor ecx, ecx ; clear ecx
	lea ecx, [eax+eax]

	xor ecx, ecx
	mov ecx, [esp]
	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
