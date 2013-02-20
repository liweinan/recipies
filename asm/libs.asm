; -------------------------------------
; libs.asm
; PURPOSE: provide general functions
; -------------------------------------

section .text
global println ; public procedures
; -------------------------------------------
; println
; PURPOSE: print characters in Buff to screen
; IN: 
;   ecx - offset of the buffer 
;   edx - length of the buffer
; OUT: nothing
; MODIFIED: nothing
; -------------------------------------------
println: ; output buffer to screen
        pushad ; save all registers
        mov eax, 4 ; sys_write call
        mov ebx, 1 ; fd = 1, stdout
        int 80h ; make kernel call
        popad ; restore all registers
        ret ; return to caller
