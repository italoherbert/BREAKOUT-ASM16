
%include "lib/stdio.mac"
%include "lib/bits.mac"

section .bss
	n1: resb 3
	n2: resb 3
	n3: resb 3
	
section .text
	global _start
	
_start:			
	mov byte [n1+2], 0xFF
	mov byte [n1+1], 0xFF
	mov byte [n1+0], 0xFF
	
	mov byte [n2+2], 0x00
	mov byte [n2+1], 0x00
	mov byte [n2+0], 0x02
			
	mulbs n3, n1, n2, 3	
			
	newline
	newline		
	printbin n1, 3
	newline
	printbin n2, 3
	newline	
	newline
	printbin n3, 3
	newline
	newline
	newline
		
	printhex n1, 3
	newline
	printhex n2, 3
	newline
	newline
	printhex n3,3
	newline
	
	cmp byte [BITS_OF], FALSE
	je overflow	
		newline
		newline
		printf "Overflow"
	overflow:
						
	jmp $
