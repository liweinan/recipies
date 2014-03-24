section .bss
	
section .data
	EatMsg:	db "Eat at Joe's!",0
section .text
	extern puts
global main
main:
	nop
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
;;; end of boilerplate
	push EatMsg
	call puts
	add esp, 4
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
