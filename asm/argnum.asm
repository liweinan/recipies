; -------------------------------------------------------------
; TITLE: argnum.asm
; DESCRIPTION: Get argument number
; AUTHOR: Weinan Li
; CREATED AT: Jul 28 2012
; USAGE: ./argnum 1 2 3
; -------------------------------------------------------------
section .data
	ARG_MSG: db 'Argument Number: ',0
	ARG_MSG_LEN: equ $-ARG_MSG
	NEW_LINE: db 10 ; \n, which is 0ah in hex
section .bss
	argNum resb 1 ; store the argument number
section .text
	extern println ; in libs.asm
	global	_start
_start:
	nop ; this makes gdb happy
;-----------------------------------------------------------------
; Main procedure
;-----------------------------------------------------------------
	mov ecx, ARG_MSG ; copy message to ecx
	mov edx, ARG_MSG_LEN ; length of string
	call println ; output to stdout 

	; get argument numbers from stack
	xor eax, eax ; clear eax to zero
	mov al, byte [esp] ; copy argument number 
	dec al ; the program name itself count 1
        add al, '0' ; covert number to ascii number
	mov [argNum], eax ; copy to variable
	mov ecx, argNum ; copy number to ecx
	mov edx, 1 ; 1 character to output
	call println

	; output '\n'
	mov ecx, NEW_LINE 
	mov edx, 1
	call println
; ----------------------------------------------------------------
; Exit 
; ----------------------------------------------------------------      
	nop
        mov eax, 1 ; exit
        mov ebx, 0 ; return 0
        int 80h
