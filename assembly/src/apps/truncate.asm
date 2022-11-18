
%include "lib/trigon.mac"
%include "lib/stdio.mac"

section .data
	n: dd -438.8901
section .text
	global _start

_start:		
	prthex32 n
	prtln
	
	truncate n
	prthex32 n		
	
	jmp $	
	