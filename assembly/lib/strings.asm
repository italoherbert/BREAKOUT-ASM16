
%ifndef STRINGS_ASM
	%define STRINGS_ASM
				
section .data				
							
proc_strlen:
	mov ax,sp
	mov bp,ax

	mov word ds, [bp+3]
	mov word si, [bp+5]
	
	mov cl,0
	.loop:
		lodsb
		cmp al,0
		jz .done
	
		inc cl
		jmp .loop
	.done:
	mov byte [bp+2], cl
	
	ret

		
proc_strcp:
	mov ax,sp
	mov bp,ax
	
	mov word es, [bp+2]
	mov word di, [bp+4]	
	mov word ds, [bp+6]
	mov word si, [bp+8]
	
	.loop:
		lodsb
		cmp al,0
		jz .done				
		stosb				
		jmp .loop
	.done:

	ret	
		
						
%endif
