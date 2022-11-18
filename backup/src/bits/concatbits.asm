
%include "lib/stdio.mac"
%include "lib/bits.mac"

section .bss
	n1: resb 3
	n2: resb 3
	n3: resb 3
	
section .text
	global _start
	
_start:			
	mov byte [n1+2], 0x00
	mov byte [n1+1], 0xAF
	mov byte [n1+0], 0xFF
	
	mov byte [n2+2], 0x00
	mov byte [n2+1], 0x00
	mov byte [n2+0], 0x0E
	
	printhex n1, 3
	newline
	printhex n2, 3
	newline
			
			
	incbs n1, 3		
	mergebs n1, n2, 3
	
	newline
	printf "CONCAT --> "
	printhex n1, 3
				
	jmp $
