section .text
_newline:
	pushad
	cmp edx, 15 ; no more than 15 lines
	ja .exit ; return if argument invalid
	mov ecx, EOLS ; addr of EOLS
	mov eax, 4 ; sys_write
	mov ebx, 1 ; stdout
	int 80h
.exit	popad
	ret
global main
main:
	mov edx, 3 
	call _newline
	

section .data
	EOLS db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
