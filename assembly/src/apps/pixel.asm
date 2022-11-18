%include "lib/stdio.mac"

%include "lib/gmode/g0x0D.mac"

%include "lib/graph.mac"

section .text
	global _start
	
_start:	
	initgraph
		
	mov ax,0x9000
	mov ds,ax
	
	mov si,200	
	mov byte [si+0],0x80
	mov byte [si+1],0x80
	mov byte [si+2],0x80
	mov byte [si+3],0x80	
	 	
	__fillrect 10, 10, 50, 50, 01h 	
	__fillrect 50, 10, 100, 50, 02h 	
	__fillrect 100, 10, 150, 50, 03h 	
	__fillrect 150, 10, 200, 50, 04h 	
	__fillrect 200, 10, 250, 50, 05h 	
	__fillrect 250, 10, 300, 50, 06h 	
	__fillrect 10, 50, 50, 90, 07h 	
	__fillrect 50, 50, 100, 90, 08h 	
	__fillrect 100, 50, 150, 90, 09h 	
	__fillrect 150, 50, 200, 90, 0Ah 	
	__fillrect 200, 50, 250, 90, 0Bh 	
	__fillrect 250, 50, 300, 90, 0Ch 	
	__fillrect 50, 90, 100, 140, 0Dh 	
	__fillrect 100, 90, 150, 140, 0Eh 	
	__fillrect 150, 90, 200, 140, 0Fh 	
	
	 	
	repaint
	
	jmp $
