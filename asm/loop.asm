; --------------------------------------------------
; loop.asm
; PURPOSE: Show the usage of loop instruction
;          It uses ecx to do the looping
; --------------------------------------------------
section .data
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
        mov edi, Buff ; Load buffer address to edi
        ; edi means 'extended destination pointer'
        xor eax, eax ; clear eax to zero
        mov al, 'A' ; copy a string to al
        mov ecx, BUF_LEN ; copy buffer length to ecx for loop
.loop1: ; a label prefixed with '.' is identified as local by nasm 
        mov byte [edi], al ; copy 'A' to Buff
        inc edi ; move to next pos in buffer
        dec ecx ; count down by one
        jnz .loop1 ; go on next character copy if ecx not zero
        mov byte [edi], 10 ; set last character to EOL
        ; EOL = end of line
        mov ecx, Buff ; pass offset of the buffer
        mov edx, BUF_LEN ; length of the buffer
        call println ; output buffer to screen
; ----------------------------------------------------------------
; .loop2 is a demonstration of loop instruction
; ---------------------------------------------------------------- 	
	mov al, 'B' ; copy a new string to al
	mov ecx, BUF_LEN ; reset counter
	mov edi, Buff ; reset pointer to Buff	
.loop2: ; in .loop2, we show the usage of 'loop' instruction
	mov byte [edi], al ; copy 'B' to Buff
	inc edi ; next one in Buff
	; The following instruction equals to:
	; dec ecx
	; jnz .loop2
	loop .loop2
	mov byte [edi], 10 ; set last character to EOL
        ; EOL = end of line
        mov ecx, Buff ; pass offset of the buffer
        mov edx, BUF_LEN ; length of the buffer
        call println ; output buffer to screen	
; ----------------------------------------------------------------
; .loop3 uses all the power from 'stosb', 'loop', and 'aaa' 
; ----------------------------------------------------------------      
        mov ecx, BUF_LEN ; reset counter
        mov edi, Buff ; reset pointer to Buff   
	mov al, '0' ; copy '0' to al
.loop3:
	; stosb equals to: 
	;    mov byte [edi], al
	;    inc edi
	stosb	
	add al, '1' ; add char value in AL up by 1
	aaa ; make it a BCD addtion
	add al, '0' ; put binary 3 in AL's high nybble 
	; the above is equals to 'or al, 30h'
	loop .loop3
	mov byte [edi], 10 ; set last character to EOL
        ; EOL = end of line
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
