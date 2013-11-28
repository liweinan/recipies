	;; Sample program to extract the processor Vendor ID
	section .data
Output db "The processor Vendor ID is 'xxxxxxxxxxxx'",10
	section .text
	global _start
_start:
	nop
	mov eax, 0
	cpuid 			; call cpuid
	movl edi, Output	; collect info into Output
	
	;; exit
	nop
	mov eax, 1 		; exit
	mov ebx, 0		; return 0
	int 80h
	
	
	
