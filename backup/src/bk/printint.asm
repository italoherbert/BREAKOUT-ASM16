
%include "lib/sys.mac"
%include "lib/stdio.mac"
%include "lib/integer.mac"

section .bss
	n: resb 4
	n2: resb 4
section .text
	global _start
	
_start:	 		
	mov byte [n+3], 0x00
	mov byte [n+2], 0x00
	mov byte [n+1], 0x00
	mov byte [n+0], 0x00
		
	setbs n2, 4, 0
	movbsb n2, 4, 0xA
	mov cx, 20			
	l1:
		cmp cx, 0
		jz l2		
		push cx
			
		addbs n, n2, 4
		printhex n, 4
		printf " --> "
		printint n, 4
		newline
	
		pop cx
		dec cx
		jmp l1
	l2:
	
	newline
	printf "END"
	
	jmp $
	