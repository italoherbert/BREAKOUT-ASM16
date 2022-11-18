 
%ifndef SYS_ASM
 	%define SYS_ASM
 	
 	%include "lib/sys.csts" 	

section .data

; DELAY
proc_delay:	
	mov cl,0
	.l1:
		mov ax,sp
		mov bp,ax
		cmp byte cl, [bp+2]
		jae .l2	
		push cx		
							
		mov ah,86h
		mov cx,0010h
		mov dx,0000
		int 15h				
		
		pop cx
		inc cl
		jmp .l1
	.l2:	
	ret
 	
%endif 