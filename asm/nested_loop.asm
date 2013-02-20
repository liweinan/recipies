; -------------------------------------------------------------
; TITLE: nested_loop.asm
; DESCRIPTION: Show how to use EAX and EBX to do nested lopp 
; AUTHOR: Weinan Li
; CREATED AT: Jul 25 2012
; -------------------------------------------------------------
section .data
	Str: db 'A'
	NewLine: db 10
section .bss
section .text
	extern println ; in lib.asm
	global	_start
_start:
	nop ; this makes gdb happy
;-----------------------------------------------------------------
; Main procedure
;-----------------------------------------------------------------
	xor eax, eax ; clear eax to zero
	mov eax, 02h ; output two lines: '12345' and 'ABCDE'
.writeLine:
        xor ebx, ebx ; clear ebx to zero
        mov ebx, 05h ; print 5 character per line
.writeCharacter:
	mov ecx, Str ; get character
	mov edx, 1 ; output 1 character to screen
	call println ; call output procedure
	dec bl ; count down the loop by one
	loopnz .writeCharacter ; loop if bl is not zero
	mov ecx, NewLine ; \n
	mov edx, 1 ; length of character
	call println ; output newline
	dec eax ; count down outer loop	
        jz .quit ; if eax goes down to zero, quit the loop
	jmp .writeLine ; output to a new line
.quit:
; ----------------------------------------------------------------
; Exit 
; ----------------------------------------------------------------      
	nop
        mov eax, 1 ; exit
        mov ebx, 0 ; return 0
        int 80h
