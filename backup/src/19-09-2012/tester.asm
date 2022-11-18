
%include "src/test/bits/bitcmp8.asm"
	
section .text
	global _start
	
_start:		
	printf "stack ---> "
	mov ax,sp
	printhex16 ax
	newline	 	
	newline
	
	initmem	
	test_bitcmp8
	
	newline
	newline
	printf "stack ---> "
	mov ax,sp
	printhex16 ax

	jmp $