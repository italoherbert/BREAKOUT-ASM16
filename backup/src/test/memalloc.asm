
%include "lib/mem.mac"
%include "lib/stdio.mac"

section .text
	global _start
	
_start:
	initmem
	
	malloc dx,ax,0x0F
	mov cx,0xFF
	l1:
		push cx
		malloc dx, ax, 0xFF
		pop cx
	loop l1
	
	malloc dx,ax,0xFF	
	
	push ax
	push dx
	
	pop ax
	printhex16 ax, TRUE
	printf ":"
	pop ax
	printhex16 ax, TRUE 
	newline
	newline
	
	mov ax, [ MEM_PPOINT + 2 ]
	printhex16 ax, TRUE
	mov ax, [ MEM_PPOINT + 0 ]
	printhex16 ax, TRUE 
		
	jmp $
	