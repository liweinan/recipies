; test which memory segment the inline data is placed into
; -------------------------------------------------------------
; $ strings inline_data
; Hello, world
; -------------------------------------------------------------
; -bash-4.2$ objdump -s  inline_data | grep  -C 10 "H" 
;
; inline_data:     file format elf32-i386
;
; Contents of section .text:
;  8048060 6061c348 656c6c6f 2c20776f 726c640a  `a.Hello, world.
;  8048070 9090b801 000000bb 00000000 cd80      ..............   
; -------------------------------------------------------------
; We can see the data is using .text code segment to store
section .text
Proc1:
	pushad ; save all registers
	
.exit	popad ; restore all registers
	ret ; return to caller
TEST_STRING db "Hello, world",10 ; test inline data

	global	_start
_start:
	nop
; Put your experiments between the two nops...


; Put your experiments between the two nops...
	nop
        mov eax, 1 ; exit
        mov ebx, 0 ; return 0
        int 80h
