
%include "lib/system.mac"
%include "lib/stdio.mac"
%include "lib/math.mac"
%include "lib/float.mac"
%include "lib/trigon.mac"
		
section .data
	n: dd -0.8
	
section .text
	global _start
	
_start:		
	prtstk
	prtln
	prtln
		
	fltoint32 n, n	
	prthex32 n
							 		
	prtln
	prtln
	prtstk			
	
	jmp $		