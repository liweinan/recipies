section .data
	TBL: db "0123456789ABCDEF"

section .bss
	var: resb 1
	
section .text
	global	_start
_start:
	nop
; Put your experiments between the two nops...
	xor eax, eax ; clear eax to zero
	mov al, 1ch ; set some value to al
	and al, 0fh ; mask out all the low nybble(little-endian)
	mov eax, [TBL + eax] ; transform number to ascii char 

	mov [var], eax ; copy value from eax to var

        mov     edx,1                 ; arg3, length of string to print
        mov     ecx,var               ; arg2, pointer to string
        mov     ebx,1                 ; arg1, where to write, screen
        mov     eax,4                 ; write command to int 80 hex
        int     0x80                  ; interrupt 80 hex, call kernel
        
	; demo of xlat	
	xor	eax, eax ; Clear eax to zero
	mov	ebx, TBL ; The address of the translation table must be in EBX
	mov	al, 0ch ; The character to be translated must be in AL
	xlat ; The trnaslated character will be returned in AL

	; printit
	mov [var], eax	
	mov edx, 1
	mov ecx,var
	mov ebx, 1
	mov eax, 4
	int 0x80	

	
; Put your experiments between the two nops...
	nop
        mov eax, 1 ; exit
        mov ebx, 0 ; return 0
        int 80h
