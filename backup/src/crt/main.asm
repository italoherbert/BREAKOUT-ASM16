%include "src/crt.asm"

section .text
	global _start

_start:	
	call inittextmode
		
	mov al,02h
	push ax
	call settextbackground
	pop ax	
		
	mov al,00h
	push ax
	call settextcolor
	pop ax	
		
	mov cx,0505h
	mov dx,134Ah
	push cx
	push dx
	call window
	pop cx
	pop dx
				
	call clrscr

	push msg1
	call write
	pop dx	

	call readln
	xor bx,bx
	mov bl,al
	push bx

	push msg2
	call write	
	pop dx			

	call readln
	xor bx,bx
	mov bl,al
	push bx	

	push msg3
	call write	
	pop dx

	pop dx
	xor bx,bx
	mov bl,dl	

	pop dx
	xor ax,ax
	mov al,dl
	
	sub ax,30h
	sub bx,30h	

	add ax, bx

	add ax,30h	
	
	push ax
	call write	

	jmp $

section .data
	msg1: db "Digite um numero: ",0
	msg2: db "Digite outro numero: ",0
	msg3: db "A soma eh: ",0
