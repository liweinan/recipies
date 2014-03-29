[section .bss]
	_line_count resd 1
[section .data]
fmt:	db "%d",0
str:	db "1",0
[section .text]
extern sscanf
global main 
main:
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
;;; end of boilerplate
	mov eax, _line_count
	push eax		; push address of line count
	mov eax, fmt		
	push eax		; push address of formatting code
	mov eax, str
	push dword eax		; push address of str
	call sscanf
	add esp, 12
;;; boilerlate
	pop edi
	pop esi
	pop ebx
	mov esp, ebp
	pop ebp
;;; end of boilerplate
	
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
