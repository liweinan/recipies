section .bss
	
section .data

section .text
global main 
main:
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
;;; end of boilerplate

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
