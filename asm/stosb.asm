section .data
	Hello: db "Hello, world!",10
	LEN equ $-Hello
section .bss
	Output resb LEN
section .text
_prepare:
	mov edi, Output
	mov ecx, LEN
	ret
_stosb:
        mov byte [edi], al
        inc edi
        dec ecx
        jnz _stosb
	ret
_stosb_real:
        call _prepare
        rep stosb
	ret
_newline:
	mov byte [Output], 10
	pushad
	mov eax, 4
	mov ebx, 1
	mov ecx, Output
	mov edx, 1
	int 80h
	popad
	ret
_write:
	pushad
        mov eax, 4 ; sys_write
        mov ebx, 1 ; stdout
        mov ecx, Output
        mov edx, LEN
        int 80h
	popad
	ret
global main 
main:
	call _prepare
	mov al, 'A'
	call _stosb
	call _write
	call _newline

	call _stosb_real
	call _write
	call _newline

	mov eax, 1 ; sys_exit
	mov ebx, 0 ; ret 0
	int 80h
