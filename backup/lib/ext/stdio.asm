
%ifndef STDIO_ASM
	%define STDIO_ASM
	
	%include "lib/crt.mac"	
	
section .data

proc_prtbin:		
	mov ax,sp
	mov bp,ax
	
	mov byte cl, [bp+6]
	mov byte bh, [bp+7]	
	
	mov bl,0
	mov dl,TRUE
	xor ch,ch
	.l1:			
		cmp cl,0
		jz .l2
							
		push bp
		mov word ax, [bp+2]
		mov ds, ax
		mov si, [bp+4]		
		add si,cx
		sub si,1		
		
		or byte bl, [si]
		or byte bl, bh
		jz .prted											
			push bx
			push cx	
			cmp dl, TRUE
			je .first
			jmp .nfirst
			.first:
				mov dl, FALSE
				push dx
				
				mov ah, bh
				mov byte al, [si]
				push ax
				call proc_prtbin8
				pop ax
							
				pop dx
				jmp .endfirst
			.nfirst:
				push dx
				
				mov ah, TRUE
				mov byte al, [si]
				push ax
				call proc_prtbin8
				pop ax
								
				pop dx
			.endfirst:	
			pop cx
			pop bx		
			
			cmp cl,1
			jbe .spaceprted
				prtch 20h
			.spaceprted:
		.prted:
		
		pop bp
	
		dec cl
		jmp .l1		
	.l2:
	
	cmp bl,0
	jnz .end
		prtch 30h
	.end:	

	ret
	
proc_prthex:
	mov ax,sp
	mov bp,ax

	mov byte cl, [bp+6]
	mov byte bh, [bp+7]	
	
	mov bl,0	
	mov dl,TRUE
	xor ch,ch
	.l1:			
		cmp cl,0
		jz .l2
							
		push bp
		
		mov ax, [bp+2]
		mov ds, ax
		mov si, [bp+4]
		add si,cx
		sub si,1		
		
		or byte bl, [si]
		or byte bl, bh
		jz .prted							
			push bx
			push cx	
			cmp dl, TRUE
			je .first
			jmp .nfirst
			.first:
				mov dl, FALSE
				push dx
				
				mov ah, bh
				mov byte al, [si]
				push ax
				call proc_prthex8
				pop ax
							
				pop dx
				jmp .endfirst
			.nfirst:
				push dx
				
				mov ah, TRUE
				mov byte al, [si]
				push ax
				call proc_prthex8
				pop ax
								
				pop dx
			.endfirst:	
			pop cx
			pop bx		
		.prted:
		
		pop bp
	
		dec cl
		jmp .l1		
	.l2:
	
	cmp bl,0
	jnz .end
		prtch 30h
	.end:
		
	ret
	
%endif