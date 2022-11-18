
%include "lib/system.mac"
%include "lib/stdio.mac"
%include "lib/math.mac"
%include "lib/float.mac"
%include "lib/trigon.mac"
		
section .data
	x1: dd -1.0
	x2: dd 1.0
	i: dd 0.2
	a: dd 0
	n: dd -0.4
	
section .text
	global _start
	
_start:		
	prtstk
	prtln
	prtln
	
	l1:		
		flcmp x1, x2, cl		
		cmp cl,0
		jg l2
		
		atan x1, a
		
		prthex32 x1
		prtch 20h
		prthex32 a
		prtln
		
		fladd x1, i, x1
		jmp l1
	l2:
						 		
	prtln
	prtln
	prtstk			
	
	jmp $		