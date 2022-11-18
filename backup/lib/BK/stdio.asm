
%ifndef STDIO_ASM
	%define STDIO_ASM
	
	%include "lib/crt.mac"

section .data

proc_printbin:		
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
		jz .printed											
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
				call proc_printbin8
				pop ax
							
				pop dx
				jmp .endfirst
			.nfirst:
				push dx
				
				mov ah, TRUE
				mov byte al, [si]
				push ax
				call proc_printbin8
				pop ax
								
				pop dx
			.endfirst:	
			pop cx
			pop bx		
			
			cmp cl,1
			jbe .spaceprinted
				writechar 20h
			.spaceprinted:
		.printed:
		
		pop bp
	
		dec cl
		jmp .l1		
	.l2:
	
	cmp bl,0
	jnz .end
		writechar 30h
	.end:	

	ret
	
proc_printbin16:
	mov ax,sp
	mov bp,ax
		
	mov bh, [bp+4]
	mov bl,0
	mov dl,TRUE
	xor ch,ch
	mov cl,2
	.l1:
		cmp cl,0
		jz .l2		
		
		push bp
		add bp,cx
		inc bp
		
		or byte bl, [bp]
		or byte bl, bh
		jz .printed											
			push bx
			push cx	
			cmp dl, TRUE
			je .first
			jmp .nfirst
			.first:
				mov dl, FALSE
				push dx
				
				mov ah, bh
				mov byte al, [bp]
				push ax
				call proc_printbin8
				pop ax
							
				pop dx
				jmp .endfirst
			.nfirst:
				push dx
				
				mov ah, TRUE
				mov byte al, [bp]
				push ax
				call proc_printbin8
				pop ax
								
				pop dx
			.endfirst:	
			pop cx
			pop bx		
			
			cmp cl,1
			jbe .spaceprinted
				writechar 20h
			.spaceprinted:
		.printed:
		
		pop bp
		
		dec cl
		jmp .l1
	.l2:
	
	cmp bl,0
	jnz .end
		writechar 30h
	.end:
	
	ret	
	
proc_printbin8:
	mov ax,sp
	mov bp,ax
	mov byte al, [bp+2]
	cmp al, 0
	jnz .nzero
		writechar 30h
		
		mov ax,sp
		mov bp,ax
		mov byte al, [bp+3]		
		cmp al, FALSE
		je .end
			writechar 30h
			writechar 30h
			writechar 30h
			writechar 30h
			writechar 30h
			writechar 30h
			writechar 30h
			jmp .end		
	.nzero:

	mov byte al, FALSE
	push ax

	mov ax,sp
	mov bp,ax
	mov byte bl, [bp+4]
	mov cl,0
	.l1:
		cmp cl,8
		jae .l2
		
		mov al,cl
		
		mov dl, bl		
		
		.l1.1:
			cmp al,0
			jz .l1.2
							
			shl dl,1
			
			dec al
			jmp .l1.1
		.l1.2:
						
		shr dl,7
		
		mov ax,sp
		mov bp,ax			
		mov byte al, [bp+5]
		cmp al, TRUE
		je .endzero		
			cmp dl,0
			jz .zero
			jmp .notzero
			.zero:
				pop ax
				push ax
				cmp al, TRUE				
				je .endzero
				jmp .inc
			.notzero:
				pop ax
				mov al, TRUE	
				push ax				
		.endzero:
									
		add dl,30h

		push cx
		push dx
		writechar dl
		pop dx
		pop cx	

		.inc:
	
		inc cl
		jmp .l1	
	.l2:
	
	pop ax
	
	.end:
	
	ret	

proc_printhex:
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
		jz .printed							
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
				call proc_printhex8
				pop ax
							
				pop dx
				jmp .endfirst
			.nfirst:
				push dx
				
				mov ah, TRUE
				mov byte al, [si]
				push ax
				call proc_printhex8
				pop ax
								
				pop dx
			.endfirst:	
			pop cx
			pop bx		
		.printed:
		
		pop bp
	
		dec cl
		jmp .l1		
	.l2:
	
	cmp bl,0
	jnz .end
		writechar 30h
	.end:
		
	ret

proc_printhex16:
	mov ax,sp
	mov bp,ax

	mov byte bh, [bp+4]		
	mov bl,0	
	mov dl,TRUE
	xor ch,ch
	mov cl, 2	
	.l1:			
		cmp cl,0
		jz .l2
							
		push bp		
		add bp,cx
		inc bp		
		
		or byte bl, [bp]
		or byte bl, bh
		jz .printed							
			push bx
			push cx	
			cmp dl, TRUE
			je .first
			jmp .nfirst
			.first:
				mov dl, FALSE
				push dx
				
				mov ah, bh
				mov byte al, [bp]
				push ax
				call proc_printhex8
				pop ax
							
				pop dx
				jmp .endfirst
			.nfirst:
				push dx
				
				mov ah, TRUE
				mov byte al, [bp]
				push ax
				call proc_printhex8
				pop ax
								
				pop dx
			.endfirst:	
			pop cx
			pop bx		
		.printed:
		
		pop bp
	
		dec cl
		jmp .l1		
	.l2:
	
	cmp bl,0
	jnz .end
		writechar 30h
	.end:
	
	ret
	
proc_printhex8:
	mov ax,sp
	mov bp,ax
	mov byte al, [bp+2]
	cmp al, 0
	jnz .nzero
		writechar 30h
		
		mov ax,sp
		mov bp,ax
		mov byte al, [bp+3]		
		cmp al, FALSE
		je .end
			writechar 30h
			jmp .end		
	.nzero:

	mov byte al, FALSE
	push ax

	mov ax,sp
	mov bp,ax
	mov byte bl, [bp+4]
	mov cl,2
	.l1:
		cmp cl,0
		jz .l2
		
		mov al,2
		sub al,cl
		
		mov dl, bl	
		
		.l1.1:
			cmp al,0
			jz .l1.2
							
			shl dl,4
			
			dec al
			jmp .l1.1
		.l1.2:
						
		shr dl,4

		mov ax,sp
		mov bp,ax			
		mov byte al, [bp+5]
		cmp al, TRUE
		je .endzero		
			cmp dl,0
			jz .zero
			jmp .notzero
			.zero:
				pop ax
				push ax
				cmp al, TRUE				
				je .endzero
				jmp .dec
			.notzero:
				pop ax
				mov al, TRUE	
				push ax				
		.endzero:
						
		cmp dl,9
		jbe .endsumseven  		
		add dl,7
		.endsumseven:
						
		add dl,30h

		push cx
		push dx
		writechar dl
		pop dx
		pop cx	

		.dec:
	
		dec cl
		jmp .l1	
	.l2:
	
	pop ax
	
	.end:
	
	ret

proc_printstr:
	mov ax,sp
	mov bp,ax
	
	mov ax, [bp+2]
	mov ds, ax
	mov si, [bp+4]						
	.loop:
		lodsb
		cmp al,0h
		jz .done
		
		push ds
		push si
					
		writechar al										
									
		pop si
		pop ds
											
		jmp .loop 
	.done:
	
	ret	
	
%endif