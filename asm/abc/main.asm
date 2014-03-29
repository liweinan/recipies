section .text

extern _puta, _putb, _putc

global _start 
_start:
	nop
	nop
	call _puta
	call _putb
	call _putc
.exit:
	mov eax, 1
	mov ebx, 0
	int 80h
