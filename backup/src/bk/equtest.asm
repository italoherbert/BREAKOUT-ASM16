
section .data
	X: equ 0x0E41

section .text
	global _start
	
_start:	
	mov ax, 1234h		
	mov ax, X
	mov bh,0
	int 10h
							
	jmp $
	