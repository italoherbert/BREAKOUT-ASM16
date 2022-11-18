
%include "lib/stdio.mac"
%include "lib/integer.mac"

section .bss
	h: resb 1
	m: resb 1
	s: resb 1

section .text
	global _start
	
_start:												
	
	mov ah,02h
	int 1Ah
	
	mov byte [h], ch
	mov byte [m], cl
	mov byte [s], dh
	
	printhex h, 1
	printf ":"
	printhex m, 1
	printf ":"
	printhex s, 1	
						
	jmp $
	