section .data

	TestValue db 17h
	
section .text
	global main	
main:
	nop
; Put your experiments between the two nops...
	mov eax, 20h
	shl eax, 1h 
; Put your experiments between the two nops...
	nop
        mov eax, 1 ; exit
        mov ebx, 0 ; return 0
        int 80h
