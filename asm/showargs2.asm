section .data
	ErrMsg db "Terminated with error.",10
	ERRLEN equ $-ErrMsg
section .bss
	MAXARGS equ 10
	ArgLens: resd MAXARGS ; Table of args lengths
section .text
global _start
_start:
	nop
	mov ebp, esp 		; save esp to ebp
; ebp now contains command line arg count
	cmp byte [ebp], MAXARGS ; see if the arguments exceeds MAXARGS
	ja _error ; if so, exit	

; now we calculate the lengths of argument pointers
	xor eax, eax
	xor ebx, ebx
_scan_one:
	mov ecx, 0000ffffh ; limit search to 65535 bytes max 
	mov edi, dword [ebp + 4 + ebx*4] ; put addr of arg to search in edi
	mov edx, edi ; copy start addr from edi to edx 
	cld ; set search directory to up-memory
	repne scasb ; search for null in string at edi
	jnz _error ; up to ecx, still not find null string
	mov byte [edi-1], 10 ; store an EOL where the null used to be
	sub edi, edx ; sub pos of 0 from start addr
	mov dword [ArgLens + ebx *4], edi ; put length of arg to table 
	inc ebx ; add 1 to argument counter
	cmp ebx, [ebp] ; all args processed?
	jb _scan_one ; of not, process another one

; display all arguments to stdout
	xor esi, esi ;
_show_em:
	mov ecx, [ebp + 4 + esi * 4] ; offset of the message
	mov eax, 4 ; specify sys_write call
	mov ebx, 1 ; stdout
	mov edx, [ArgLens + esi * 4] ; pass the length of the message
	int 80h
	inc esi
	cmp esi, [ebp]
	jb _show_em
	jmp _exit
_error:
	mov eax, 4
	mov ebx, 1
	mov ecx, ErrMsg
	mov edx, ERRLEN
	int 80h
_exit:
	mov eax, 1
	mov ebx, 0
	int 80h

