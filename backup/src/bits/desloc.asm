
%include "lib/sys.mac"
%include "lib/stdio.mac"
%include "lib/math.mac"
%include "lib/bits.mac"

section .bss
	n: resb 3
	
section .text
	global _start
	
_start:
	mov ax,ds
	mov es,ax
	mov di,n
	
	mov al,10011010b
	stosb
	mov al,01111000b
	stosb	
	mov al,01010110b
	stosb	
	mov al,00110100b
	stosb	
	mov al,00010010b
	stosb
	
	printbin n, 5
	
	shlbs n, 5, 35
	
	newline
	printbin n, 5

	jmp $