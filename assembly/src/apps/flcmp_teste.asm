
%include "lib/float.mac"
%include "lib/stdio.mac"

section .data
	x: dd 0.0
	y: dd 0.2
	z: dd -1.0
	
	n1: dd 2.0
	n2: dd 4.0
	
	n3: dd -4.0
	n4: dd -2.0

section .text
	global _start
	
_start:		
	printf "0 cmp 0 --> "
	flcmp x, x, cl
	prthex8 cl
	prtln
		
	printf "0 cmp p --> "
	flcmp x, y, cl
	prthex8 cl
	prtln
	
	printf "p cmp 0 --> "
	flcmp y, x, cl
	prthex8 cl
	prtln
	
	printf "0 cmp n --> "
	flcmp x, z, cl
	prthex8 cl
	prtln
	
	printf "n cmp 0 --> "
	flcmp z, x, cl
	prthex8 cl
	prtln
	
	printf "p cmp n --> "
	flcmp y, z, cl
	prthex8 cl
	prtln
	
	printf "n cmp p --> "
	flcmp z, y, cl
	prthex8 cl
	prtln
	
	printf "2 cmp 4 --> "
	flcmp n1, n2, cl
	prthex8 cl
	prtln
	
	printf "4 cmp 2 --> "
	flcmp n2, n1, cl
	prthex8 cl
	prtln
	
	printf "-2 cmp -4 --> "
	flcmp n3, n4, cl
	prthex8 cl
	prtln
	
	printf "-4 cmp -2 --> "
	flcmp n4, n3, cl
	prthex8 cl
	prtln
	
	jmp $			