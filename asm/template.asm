; -------------------------------------------------------------
; TITLE: sandbox.asm
; DESCRIPTION: Put the purpose of this program  here 
; AUTHOR: Weinan Li
; CREATED AT: Jul 25 2012
; -------------------------------------------------------------
section .data

section .bss

section .text
	global	_start
_start:
	nop ; this makes gdb happy
;-----------------------------------------------------------------
; Main procedure
;-----------------------------------------------------------------

; ----------------------------------------------------------------
; Exit 
; ----------------------------------------------------------------      
	nop
        mov eax, 1 ; exit
        mov ebx, 0 ; return 0
        int 80h
