section .bss
	Out: resb 1 
section .data

section .text
_writeln:
	pushad
	mov eax, 4 ; sys_write
	mov ebx, 1 ; stdout
	mov ecx, Out
	mov edx, 1 
	int 80h
	popad
	ret
global _start 
_start:
	xor ecx, ecx
	mov ecx, 10h
.dec:	xor eax, eax
	dec ecx
	mov edi, Out
	mov eax, ecx
	add al, 30h	
	mov byte [edi], al
	call _writeln
	jcxz .end
	jmp .dec
.end:	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
