section .data
	MsgA: db "a",10
	MsgB: db "b",10
	MsgC: db "c",10
	MsgLen equ $-MsgC
section .text
global _puta, _putb, _putc

_puta:
	push ecx
	mov ecx, MsgA
	call _puts
	pop ecx
	ret
_putb:
	push ecx
	mov ecx, MsgB
	call _puts
	pop ecx
	ret
_putc:
	push ecx
	mov ecx, MsgC
	call _puts
	pop ecx
	ret
_puts:
	push eax
	push ebx
	push edx
	mov eax, 4
	mov ebx, 1
	mov edx, MsgLen
	int 80h
	pop edx
	pop ebx
	pop eax
	ret
