section .bss
	
section .data
	HEXSTR equ 0FEh
section .text
global main 
main:
	xor eax, eax
	jmp near _exit
_shortjmp:
	mov eax, HEXSTR
	jmp _exit
_exit:
	cmp eax, HEXSTR
	jne _shortjmp	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h

