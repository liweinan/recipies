section .data
section .bss ; bss segment contains uninitialized data
	BUF_LEN equ 10
        Buff resb BUF_LEN ; a buffer that can hold 10 characters
section .text
; ------------------
; println
; IN: nothing
; OUT: nothing
; MODIFIED: nothing
println: ; output buffer to screen
	pushad ; save all registers
        mov eax, 4 ; sys_write call
        mov ebx, 1 ; fd = 1, stdout
        mov ecx, Buff ; pass offset of the buffer
        mov edx, BUF_LEN ; length of the buffer
        int 80h ; make kernel call
	popad ; restore all registers
	ret ; return to caller
; -----------------
; main function now	
	global	_start
_start:
	nop
; Put your experiments between the two nops...
	mov edi, Buff ; Load buffer address to edi
	; edi means 'extended destination pointer'
	xor eax, eax ; clear eax to zero
	mov al, 'A' ; copy a string to al
	mov ecx, BUF_LEN ; set buffer length for '.copy'
.copy: ; fill Buff with 'A'
	mov byte [edi], al ; copy '1' to Buff
	inc edi ; move to next pos in buffer
	dec ecx ; count down by one
	jnz .copy ; go on next character copy if ecx not zero
	dec edi ; go back one pos
	mov byte [edi], 10 ; set last character to EOL
	; EOL = end of line
	call println ; output buffer to screen

; Now let's try to use stosb
	mov al, 'B' ; copy a string to al
	mov ecx, BUF_LEN ; set ecx to BUF_LEN for 'rep' command
	dec ecx ; same effect as 'dec edi' above
	mov edi, Buff ; Load buffer addresss to edi
	rep stosb ; this command will help us to do all the things in '.copy' on above
	call println ; output buffer to screen
; Put your experiments between the two nops...
	nop
        mov eax, 1 ; exit
        mov ebx, 0 ; return 0
        int 80h
