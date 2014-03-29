section .data
	ClearTerm: db 27,"[01;01H"
	CLEARLEN equ $-ClearTerm
	SCRWIDTH equ 0
section .text
; _clrscr: clear the linux console
; IN: nothing
; RETURNS: nothing
; MOFIFIED: nothing
; CALLS: sys_write(kernel)
; DESCRIPTION: sends the predefined control string <ESC>[2J to the console, which clears the full display  
_clrscr:
	push ecx	
	push edx
	mov ecx, ClearTerm
	mov edx, CLEARLEN
	call _write_str
	pop edx
	pop ecx
	ret
_write_str:
	push eax
	push ebx
	mov eax, 4 ; sys_write
	mov ebx, 1 ; stdout
	int 80h
	pop ebx
	pop eax
	ret	
; _write_ctr
_write_ctr:
	push ebx
	xor ebx, ebx
	mov bl, SCRWIDTH ; Load the screen width value
	sub bl, dl ; dl = the length of string
	shr bl, 1 ; bl = bl / 2
	mov ah, bl ; _goto_x_y needs X in ah
	call _goto_xy
	call _write_str
	pop ebx 
	ret
_goto_xy:
	ret

global main
main:
	call _clrscr
