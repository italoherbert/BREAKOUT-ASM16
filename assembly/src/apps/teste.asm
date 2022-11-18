section .text
	global _start
	
_start:
	mov ah,0Eh
	mov al,41h
	mov bh,0
	int 10h
	
	jmp $
