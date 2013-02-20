; --------------------------------------------------
; loop.asm
; PURPOSE: Show the usage of loop instruction
;          It uses ecx to do the looping
; --------------------------------------------------
section .data
	SrcData db "ABCDEFGHI",10
section .bss
	BUF_LEN equ 10
	Buff resb BUF_LEN
section .text
        extern println ; in lib.asm
	global	_start
_start:
	nop
; ----------------------------------------------------------------
; .loop1 is a 'raw' method for string manipulation 
; ----------------------------------------------------------------      
	mov esi, SrcData ; Copy source to esi(source pointer)
        mov edi, Buff ; Load buffer address to edi
        ; edi means 'extended destination pointer'
        mov ecx, BUF_LEN ; copy buffer length to ecx for loop
.loop1: ; a label prefixed with '.' is identified as local by nasm 
	movsb ; copy string from source to destination
        dec ecx ; count down by one
        jnz .loop1 ; go on next character copy if ecx not zero
        mov ecx, Buff ; pass offset of the buffer
        mov edx, BUF_LEN ; length of the buffer
        call println ; output buffer to screen
; ----------------------------------------------------------------
; Exit 
; ----------------------------------------------------------------      
	nop
        mov eax, 1 ; exit
        mov ebx, 0 ; return 0
        int 80h
