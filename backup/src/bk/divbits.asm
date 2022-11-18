
%include "lib/stdio.mac"
%include "lib/bits.mac"

section .bss
	n1: resb 3
	n2: resb 3
	q: resb 3
	r: resb 3
	
section .text
	global _start
	
_start:			
	mov byte [n1+2], 0x00
	mov byte [n1+1], 0xF0
	mov byte [n1+0], 0x00
	
	mov byte [n2+2], 0x05
	mov byte [n2+1], 0xF0
	mov byte [n2+0], 0x31
			
	divbs q, r, n1, n2, 3	
			
	newline
	printhex n1, 3	
	printf " / "
	printhex n2, 3
	printf " = "
	printhex q, 3
	newline
	printhex n1, 3	
	printf " % "
	printhex n2, 3
	printf " = "	
	printhex r, 3
	newline
	newline
	newline
	
	cmp byte [BITS_OF], FALSE
	je overflow	
		newline
		newline
		printf "Overflow"
	overflow:
						
	jmp $
