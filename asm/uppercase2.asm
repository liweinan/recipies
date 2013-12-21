section .bss
	BUFFLEN equ 1024 	; length of buffer
	Buff resb BUFFLEN
	
section .data

section .text
global main 
main:
	nop
_read:
	mov eax, 3		; sys_read
	mov ebx, 0		; fd0: stdin
	mov ecx, Buff		; input copy to buff
	mov edx, BUFFLEN 	; read BUFFLEN chars from stdin
	int 80h 		; call sys_read

	mov esi, eax		; backup number of read bytes	
	cmp eax, 0 		; compare sys_read's return value
	je _exit 		; if EOF then exit

	;; setup registers for buffer processing
	mov ecx, esi 		; restore number of read bytes
	mov ebp, Buff		; ebp points to Buff
	dec ebp			; correct offset
_scan:	
	cmp byte [ebp+ecx], 61h	; below 'a', not lowercase
	jb _next		; process next char in buffer

	cmp byte[ebp+ecx], 7ah	; above 'z', not lowercase
	ja _next		; directly write

	sub byte [ebp+ecx], 20h	; change to uppercase
_next:
	dec ecx 		; decrease counter
	jnz _scan		; process next char
_write:
	mov eax, 4		; sys_write
	mov ebx, 1		; fd1 = stdout
	mov ecx, Buff		; addr of char to write
	mov edx, esi		; write bytes
	int 80h			; call sys_write
	jmp _read		; go for next input char
_exit:	

	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
