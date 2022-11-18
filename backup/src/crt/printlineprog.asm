%include "lib/crt.mac"

section .text
	global _start	

_start:		
	inittextmode
	
	writehex 1234h
		
	textcolor 07h
	gotoxy 00h, 00h
			
	window 05h, 05h, 4Ah, 0Fh	
	textbackground 04h	
	clrscr
	
	window 06h, 06h, 49h, 0Eh		
	textbackground 00h	
	clrscr
			
	loop1:	
		mov ah,00h
		int 16h
		
		cmp al,1Bh
		je endloop1
			
		mov cx,44h
		loop2:
			push cx
			
			write 01h
			
			pop cx
		loop loop2
		jmp loop1	
	endloop1:	
					
	jmp $