;  Source name     : BOILER.ASM
;  Executable name : BOILER -- though this isn't intended to be run!
;  Version         : 2.0
;  Created date    : 10/1/1999
;  Last update     : 5/26/2009
;  Author          : Jeff Duntemann
;  Description     : A "skeleton" program in assembly for Linux, using NASM 2.05,
;	demonstrating the necessary code to preserve and restore EBP, EBX, ESI,
;	and EDI. The program does nothing and is provided as boilerplate for
;	assembly projects that link to functions written in C.
;
;  Build using these commands:
;    nasm -f elf -g -F stabs boiler.asm
;    gcc boiler.o -o boiler


[SECTION .data]			; Section containing initialised data
	HelloWorld: db "Hello, world",10,0 ; \n and EOF
	
[SECTION .bss]			; Section containing uninitialized data


[SECTION .text]			; Section containing code
	extern puts					
global main			; Required so linker can find entry point
	
main:
        push ebp		; Set up stack frame for debugger
	mov ebp,esp
	push ebx		; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
	;;; Everything before this is boilerplate; use it for all ordinary apps!	
	push HelloWorld
	call puts
	add esp, 4	
	
	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi			; Restore saved registers
	pop esi
	pop ebx
	mov esp,ebp		; Destroy stack frame before returning
	pop ebp
	ret			; Return control to Linux
