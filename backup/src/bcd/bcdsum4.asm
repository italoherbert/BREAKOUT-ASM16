%include "lib/sys.mac"
%include "lib/stdio.mac"
%include "lib/math.mac"

section .bss
	n: resw 1
	str: resb 9
	overflow_msg: resb 16

section .text
	global _start
	
_start:	
	bcdsum4 n, 09h, 09h
	cmp byte [MATH_OF], TRUE
	je overflow
	jmp notoverflow
	
	overflow:
		loadstr overflow_msg,"houve overflow"
		printf overflow_msg
		jmp endoverflow	
	notoverflow:	
		mov byte ah,[n]
		mov byte al,[n+1]	
		tohexstr str, ax			
		printf str	
	endoverflow:

	jmp $