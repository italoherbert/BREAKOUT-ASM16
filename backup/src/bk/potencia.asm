
section .bss
	n: resb 0x100

section .text
	global _start
	
_start:	
	mov ax, 0x50
	mov ds, ax
 			
	mov di, n	
	mov cx, 0
	l1:
		cmp cx, 100h	
		jae l2
				
		mov ah,0Eh
		mov bh,0
		mov al, cl
		int 10h
		
		stosb
		
		inc di
	
		inc cx
		jmp l1
	l2:		
					
	jmp $
	