%include "lib/stdio.mac"
%include "lib/bits.mac"

section .bss
	n1: resb 3
	n2: resb 3
	
section .text
	global _start
	
_start:		
	mov ax,ds
	mov es,ax
	
	mov di,n1	
	mov al,00000000b
	stosb
	mov al,00000000b
	stosb
	mov al,11000000b
	stosb	
	
	mov di,n2
	mov al,11000100b
	stosb
	mov al,00100000b
	stosb	
	mov al,00000000b
	stosb	
	
	printbin n1, 3
	newline
	printbin n2, 3
	newline
	
	subbs n1, n2, 3
	
	newline
	printbin n1, 3
	
	jmp $