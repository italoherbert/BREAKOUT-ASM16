
%include "lib/stdio.mac"
%include "lib/time.mac"

section .bss
	n: resb 6
	n2: resb 6
	q: resb 6
	r: resb 6

section .text
	global _start
	
_start:			
	int 4Ah
										
	ptimercount
							
	jmp $
	