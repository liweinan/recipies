; Descr: demostrating procedures
; Build: 
;    nasm -f elf64 -g -F stabs hexdump2.asm
;    ld -o hexdump2 hexdump2.o

SECTION .bss        ; uninit data

    BUFFLEN equ 10
    Buff resb BUFFLEN

SECTION .data       ; init data

; Here we have two parts of a single useful data structure, implementing
; the text line of a hex dump utility. The first part displays 16 bytes in
; hex separated by spaces. Immediately following is a 16-character line 
; delimited by vertical bar characters. Because they are adjacent, the two
; parts can be referenced separately or as a single contiguous unit.
; Remember that if DumpLin is to be used separately, you must append an 
; EOL before sending it to the Linux console.

DumpLin: db " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
DUMPLEN  equ $-DumpLin
ASCLin:  db "|................|", 10
ASCLEN   equ $-ASCLin
FULLLEN  equ $-DumpLin

; The HexDigits table is used to convert numeric values to their hex
; equivalents. Index by nybble without a scale: [HexDigits+eax]
HexDigits: db "0123456789ABCDEF"

; This table is used for ASCII character translation, into the ASCII
; portion of the hex dump line, via XLAT or ordinary memory lookup.
; All printable characters "play through" as themselves. The high 128
; characters are translated to ASCII period (2Eh). The non-printable
; characters in the low 128 are also translated to ASCII period, as is
; char 127.

DotXlat:
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh
    db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh
    db 40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
    db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,5Bh,5Ch,5Dh,5Eh,5Fh
    db 60h,61h,62h,63h,64h,65h,66h,67h,68h,69h,6Ah,6Bh,6Ch,6Dh,6Eh,6Fh
    db 70h,71h,72h,73h,74h,75h,76h,77h,78h,79h,7Ah,7Bh,7Ch,7Dh,7Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
    db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh

SECTION .text       ; Section containing code

;----------------------------------------------------------------------
; ClearLine: Clear a hex dump line string to 16 0 values
; IN:         Nothing
; RETURNS:    Nothing
; MODIFIES:   Nothing
; CALLS:      DumpChar
; DESCRIPTION: The hex dump line string is cleared to binary 0 by
;              calling DumpChar 16 times, passing it 0 each time.

ClearLine:
        pushad          ; save all caller's GP registers
        mov edx, 15     ; we're going to go 16 pokes, counting from 0
.poke:  mov eax, 0      ; tell DumpChar to poke a '0'
        call DumpChar   ; insert '0' into the hex dump string
        sub edx, 1      ; DEC doesn't affect CF!
        jae .poke       ; loop back if EDX >= 0
        popad           ; restore all caller's GP registers
        ret             ; go home

;----------------------------------------------------------------------
; DumpChar:    "Poke" a value into the hex dump line string.
; IN:          Pass the 8-bit value to be poked in EAX.
;              Pass the value's position in the line (0-15) in EDX
; RETURNS:     Nothing
; MODIFIES:    EAX, ASCLin, DumpLin
; CALLS:       Nothing
; DESCRIPTION: The value passed in EAX will be put in both the hex dump
;              portion and in the ASCII portion, at the position passed
;              in EDX, represented by a space where it is not a
;              printable character.

DumpChar:
    push ebx            ; save caller's EBX
    push edi            ; save caller's EDI

; first we insert the input char into the ASCII portion of the dump line
    mov bl, byte [DotXlat+eax]  ; translate nonprintables to '.'
    mov byte [ASCLin+edx+1], bl ; write to ASCII portion

; next we insert the hex equivalent of the input char in the hex portion
; of the hex dump line:
    mov ebx, eax            ; save a second copy of the input char
    lea edi, [edx*2+edx]    ; calc offset into line string (EDX X 3)

; look up low nybble character and insert it into the string:
    and eax, 0000000Fh      ; mask out all but the low nybble
    mov al, byte [HexDigits + eax]  ; look up the char equiv. of nybble !!!!11111oneoneone
    mov byte [DumpLin+edi+2], al    ; write the char equiv. to line string

; look up high nybble character and insert it into the string:
    and ebx, 000000F0h      ; mask out all the but second-lowest nybble
    shr ebx, 4              ; shift right 4 bits of byte into low 4 bits
    mov bl, byte [HexDigits+ebx]    ; look up char equiv. of nybble
    mov byte [DumpLin+edi+1], bl    ; write the char equiv. to line string

; Done! Let's go home:
    pop edi     ; restore caller's EDI
    pop ebx     ; restore caller's EBX
    ret         ; return to caller

;----------------------------------------------------------------------
; PrintLine:   Displays DumpLin to stdout
; IN:          Nothing
; RETURNS:     Nothing
; MODIFIES:    Nothing
; CALLS:       Kernel sys_write
; DESCRIPTION: The hex dump line string DumpLin is displayed to stdout
;              using INT 80h sys_write. All GP registers are preserved. 

PrintLine:
    pushad      ; save all caller's GP registers
    mov eax, 4  ; specify sys_write call
    mov ebx, 1  ; stdout
    mov ecx, DumpLin    ; pass offset of line string
    mov edx, FULLLEN    ; pass size of the line string
    int 80h     ; make kernel call to display line string
    popad       ; restore all caller's GP registers
    ret         ; return to caller

;----------------------------------------------------------------------
; LoadBuff:    Fills a buffer with data from stdin via INT 80h sys_read
; IN:          Nothing
; RETURNS:     # of bytes read in EBP
; MODIFIES:    ECX, EBP, Buff
; CALLS:       Kernel sys_write
; DESCRIPTION: Loads a buffer full of data (BUFFLEN bytes) from stdin
;              using INT 80h sys_read and places it in Buff. Buffer
;              offset counter ECX is zeroed, because we're starting in
;              on a new buffer full of data. Caller must test value in
;              EBP: If EBP contains zero on return, we hit EOF on stdin.
;              Less than 0 in EBP on return indicates some kind of error.

LoadBuff:
    push eax            ; save caller's EAX
    push ebx
    push edx
    mov eax, 3          ; sys_read
    mov ebx, 0          ; stdin
    mov ecx, Buff
    mov edx, BUFFLEN    
    int 80h
    mov ebp, eax
    xor ecx, ecx        ; clear buffer pointer ECX to 0
    pop edx             ; restore caller's EDX
    pop ebx             ; restore caller's EBX
    pop eax
    ret

GLOBAL main  

;----------------------------------------------------------------------
; Eventually here we start
;----------------------------------------------------------------------
main:
    nop             ; for gdb
    nop
 
; Whatever initialization needs doing before the loop scan starts is here:
    xor esi, esi    ; clear total byte counter to 0
    call LoadBuff   ; read first buffer of data from stdin
    cmp ebp, 0      ; if ebp=0, sys_read reached EOF on stdin
    jbe Exit          

; Go through the buffer and convert binary byte values to hex digits:
Scan:
    xor eax, eax            ; eax = 0
    mov al, byte[Buff+ecx]  ; get a byte from the buffer into AL
    mov edx, esi            ; copy total counter into EDX
    and edx, 0000000Fh      ; mask out lowest 4 bits of char counter
    call DumpChar           ; call the char poke procedure

; Bump the buffer pointer to the next character and see if buffer's done:
    inc esi                 ; increment total chars processed counter
    inc ecx                 ; increment buffer pointer
    cmp ecx, ebp            ; compare with # of chars in buffer
    jb .modTest             ; if we've processed all chars in buffer...
    call LoadBuff           ; ...go fill the buffer again
    cmp ebp, 0              ; if ebp=0, sys_read reached EOF on stdin
    jbe Done                ; if we got EOF, we're done (how clever)

; see if we're at the end of a block of 16 and need to display a line:
.modTest:
    test esi, 0000000Fh     ; test 4 lowest bits in counter for 0
    jnz Scan                ; if counter is *not* modulo 16, loop back
    call PrintLine          ; ...otherwise print the line
    call ClearLine          ; clear hex dump line to 0's
    jmp Scan                ; continue scanning the buffer

; Well, the party is over, let's get out from here:
Done:
    call PrintLine          ; print the "leftovers" line
Exit:
    mov eax, 1              ; exit syscall
    mov ebx, 0              ; return a code of zero
    int 80h                 ; do it! 