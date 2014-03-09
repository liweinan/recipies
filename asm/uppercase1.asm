section .bss
	buff resb 1
	
section .data

section .text
global main 
main:
	nop
_read:
	mov eax, 3		; sys_read
	mov ebx, 0		; fd0: stdin
	mov ecx, buff		; input copy to buff
	mov edx, 1 		; read one char from stdin
	int 80h 		; call sys_read

	cmp eax, 0 		; compare sys_read's return value
	je _exit 		; if EOF then exit

	cmp byte [buff], 61h 	; below 'a', not lowercase
	jb _write		; directly write

	cmp byte[buff], 7ah	; above 'z', not lowercase
	ja _write		; directly write
	sub byte [buff], 20h	; change to uppercase
_write:
	mov eax, 4		; sys_write
	mov ebx, 1		; fd1 = stdout
	mov ecx, buff		; addr of char to write
	mov edx, 1		; write one char
	int 80h			; call sys_write
	jmp _read		; go for next input char
_exit:	

	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
