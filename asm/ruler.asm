section .bss
	Output resb 1	
section .data

section .text
global main 
main:
	xor eax, eax
	mov al,9
_output:
	xor ebx, ebx
	mov bl, 30h
	add al, bl
	mov byte [Output], al 

	push eax

	mov eax, 4 ; sys_write
	mov ebx, 1
	mov ecx, Output
	mov edx, 1
	int 80h

	pop eax
	aaa ; clear higher nybbles (30h) 
	dec al
	jnz _output
_exit:	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
