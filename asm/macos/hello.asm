;  hello.asm  a first program for nasm for MacOS, Intel, gcc
;
; assemble:	nasm -f elf -l hello.lst  hello.asm
; link:		gcc -o hello  hello.o
; run:	        hello 
; output is:	Hello World

	SECTION .data		; data section
msg:	db "Hello, world!",10	; the string to print, 10=cr
len:	equ $-msg		; "$" means "here"
				; len is a value, not an address

	SECTION .text		; code section
        global main		; make label available to linker 
_syscall:
	int 0x80
	ret
main:				; standard  gcc  entry point
	
	;mov	edx,len		; arg3, length of string to print
	push dword len
	;mov	ecx,msg		; arg2, pointer to string
	push dword msg
	;mov	ebx,1		; arg1, where to write, screen
	push dword 1
	mov	eax,4		; write command to int 80 hex
	;int	0x80		; interrupt 80 hex, call kernel
	;  http://www.freebsd.org/doc/en/books/developers-handbook/x86-system-calls.html
	call _syscall
	
	;mov	ebx,0		; exit code, 0=normal
	;mov	eax,1		; exit command to kernel
	;int	0x80		; interrupt 80 hex, call kernel
	add esp, 12  ; Clean stack (3 arguments * 4)
	push dword 0
	mov eax, 0x1
	call _syscall

