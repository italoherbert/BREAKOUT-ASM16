
%include "lib/stdio.mac"
%include "lib/bits.mac"

section .bss
	n: resb 3
	bit: resb 1
	count: resb 1
	
section .text
	global _start
	
_start:			
	mov byte [n+2], 00010010b
	mov byte [n+1], 00110100b
	mov byte [n+0], 01010110b
	
	printbin n, 3
	newline
	newline
	
	
	xor ch,ch
	mov cl,0
	l1:
		cmp cl,18h
		jae l2		
		push cx
	
		mov byte [count], cl		
		loadbitbs bit, n, 3, [count]
		
		cmp byte [bit],0
		jz zero
		jmp one
		zero:
			writechar 30h
			jmp endzeroone
		one:
			writechar 31h
		endzeroone:
		
		pop cx
		inc cl
		jmp l1
	l2:
	;%endif
				
	jmp $
