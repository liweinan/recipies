section .bss
	BUFFLEN equ 16
	Buff: resb BUFFLEN

section .data
	HexStr: db " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00",10
	HEXLEN equ $-HexStr
	Digits: db "0123456789ABCDEF"

section .text
global main
main:
	nop
_read:
	mov eax, 3 ; sys_read
	mov ebx, 0 ; fd0 = stdin
	mov ecx, Buff
	mov edx, BUFFLEN
	int 80h
	
	mov ebp, eax ; save read bytes number
	cmp eax, 0 ; EOF
	je _done ; jumps to end if equals to EOF
	
	mov esi, Buff ; save buffer address
	mov edi, HexStr ; save line string address
	xor ecx, ecx ; clear ecx for future usage

_scan:
	xor eax, eax ; clear eax
	mov edx, ecx ; ecx is used as counter.
	shl edx, 1 ; edx = ecx * 2
	add edx, ecx ; edx = ecx * 2 + ecx = ecx * 3
	
	;; Get a character from buffer
	mov al, byte [esi+ecx] ; get one char into al
	mov ebx, eax ; copy to bl
	
	and al, 0fh ; 0fh = 0000ffffb
	mov al, byte [Digits + eax] ; lookup table
	mov byte [HexStr + edx + 2], al ; Write to output string
	
	shr bl, 4
	mov bl, byte [Digits + ebx]
	mov byte [HexStr + edx + 1], bl
	
	inc ecx,
	cmp ecx, ebp
	jna _scan
	
_write:
	mov eax, 4 ; sys_write
	mov ebx, 1 ; fd = 1, stdout
	mov ecx, HexStr
	mov edx, HEXLEN
	int 80h
_clear:
	xor eax, eax
	mov eax, 0fh
	mov byte [HexStr + eax], 0
	dec eax
	jnz _clear
	jmp _read

_done:
	mov eax, 1
	mov ebx, 0
	int 80h
	
	
