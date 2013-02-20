section .data

	TestValue db 17h
	
section .text
	global	_start
_start:
	nop
; Put your experiments between the two nops...
	push esp ;this will cause the program malfunction

; Put your experiments between the two nops...
	nop
        mov eax, 1 ; exit
        mov ebx, 0 ; return 0
        int 80h
