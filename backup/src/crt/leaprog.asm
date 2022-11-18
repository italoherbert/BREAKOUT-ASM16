%include "src/crt.asm"

section .text
	global _start
	
_start:
	call inittextmode
	
	mov ax,0002h
	mov ds,ax
	
	push ds
	call writehex
	pop ds
	
	lea ax,[ds:0001h]
	
	push ax
	call writehex
	pop ax
		
	jmp $
	

