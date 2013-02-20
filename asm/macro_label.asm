%include "macro_lib.mac"

section .data
	
section .text
	global	_start
_start:
	nop
; Put your experiments between the two nops...

; the label in .mac file will be expanded:
; The format is by prefix "..@" with seq number
; $ objdump -D ./macro_label | grep label_a
; 0804806b <..@3.label_a>:
	my_call 1, 2

; Put your experiments between the two nops...
	nop
        mov eax, 1 ; exit
        mov ebx, 0 ; return 0
        int 80h
