section .text
%macro _m_call 2
	mov eax, %1
	mov ebx, %2
	int 80h
%endmacro

global main 
main:
	nop
	_m_call 3, 0 ; 3 = sys_read, 0 = stdin
	_m_call 1, 0 ; 1 = exit(kernel) 0 = return code
