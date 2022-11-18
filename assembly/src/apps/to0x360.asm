
%include "lib/trigon.mac"
%include "lib/stdio.mac"

section .data
	a: dd 40.0
	ang: dw 0
section .text
	global _start

_start:		
	toradians a
	to0x360 a
	
	prthex32 a
	prtln
		
	todegrees a
	flroundtoint16 a, ang
	
	int16toreg ang, ax
	prthex16 ax
	
	jmp $	
	