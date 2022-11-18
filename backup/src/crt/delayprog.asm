%include "src/crt.asm"
%include "src/sys.asm"
%include "src/test.asm"

section .text
	global _start

_start:	
	call inittextmode			
						
	mov ax,0xF3C9
	push ax
	call writehex
	pop ax
	
	call newline			
						
	mov cx,0Ah
	loop1:
		push cx		
		
		mov al,03h
		push ax
		call write
		pop ax						
		
		mov ax,0002h
		push ax
		call delay
		pop ax 	
				
		pop cx
	loop loop1
	
	jmp $