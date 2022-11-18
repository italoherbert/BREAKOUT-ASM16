
%ifndef STDIO_ASM
	%define STDIO_ASM
	
	%include "lib/system.mac"
	
%macro __prtch 1	
	stkopen 1	
	mov byte [ bp ], %1
	call proc_prtch
	stkclose 1
%endmacro

%macro __prtln 0
	call proc_prtln
%endmacro	

%macro __prtsubbin8 3
	stkopen 3
	mov byte [bp+0],%1
	mov byte [bp+1],%2
	mov byte [bp+2],%3
	call proc_prtsubbin8
	stkclose 3
%endmacro
	
section .data
	
proc_prtIEEE754:
	mov ax,sp
	mov bp,ax			
	mov ax,[bp+2]	
	push ax
	push ax
	push ax
	push ax	
	push ax
	
	__prtsubbin8 ah,0,1
	__prtch 20h
	__prtch 20h
	pop ax
	__prtsubbin8 ah,1,5
	pop ax
	__prtsubbin8 ah,5,8
	
	pop ax
	__prtsubbin8 al,0,1
	__prtch 20h
	__prtch 20h
	pop ax
	__prtsubbin8 al,1,4
	__prtch 20h
	pop ax
	__prtsubbin8 al,4,8
	__prtch 20h
	
	mov ax,sp
	mov bp,ax			
	mov ax,[bp+4]
	push ax
	push ax
	push ax
	
	__prtsubbin8 ah,0,4
	__prtch 20h
	pop ax
	__prtsubbin8 ah,4,8
	__prtch 20h
	
	pop ax
	__prtsubbin8 al,0,4
	__prtch 20h
	pop ax
	__prtsubbin8 al,4,8
	__prtch 20h
	
	ret
	
proc_prtsubbin8:
	mov ax,sp
	mov bp,ax
	
	mov al,[bp+2]
	push ax
	
	mov cl,[bp+3]
	mov ch,[bp+4]
	cmp ch,8
	jbe .l1	
		mov ch,8
	.l1:		
		cmp cl,ch		
		jae .l2
		
		pop ax
		push ax
		shl al,cl
		shr al,7		
		add al,30h
		
		push cx
		__prtch al
		pop cx
		
		inc cl
		jmp .l1
	.l2:	
	pop ax
	
	ret
	
proc_prtbin16:
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
				mov byte al, [bp]
				push ax
				call proc_prtbin8
				pop ax
							
				pop dx
				jmp .endfirst
			.nfirst:
				push dx
				
				mov ah, TRUE
				mov byte al, [bp]
				push ax
				call proc_prtbin8
				pop ax
								
				pop dx
			.endfirst:	
			pop cx
			pop bx		
			
			cmp cl,1
			jbe .spaceprted
				__prtch 20h
			.spaceprted:
		.prted:
		
		pop bp
		
		dec cl
		jmp .l1
	.l2:
	
	cmp bl,0
	jnz .end
		__prtch 30h
	.end:
	
	ret	
	
proc_prtbin8:
	mov ax,sp
	mov bp,ax
	mov byte al, [bp+2]
	cmp al, 0
	jnz .nzero
		__prtch 30h
		
		mov ax,sp
		mov bp,ax
		mov byte al, [bp+3]		
		cmp al, FALSE
		je .end
			__prtch 30h
			__prtch 30h
			__prtch 30h
			__prtch 30h
			__prtch 30h
			__prtch 30h
			__prtch 30h
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
		__prtch dl
		pop dx
		pop cx	

		.inc:
	
		inc cl
		jmp .l1	
	.l2:
	
	pop ax
	
	.end:
	
	ret	

proc_prthex16:
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
				mov byte al, [bp]
				push ax
				call proc_prthex8
				pop ax
							
				pop dx
				jmp .endfirst
			.nfirst:
				push dx
				
				mov ah, TRUE
				mov byte al, [bp]
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
		__prtch 30h
	.end:
	
	ret
	
proc_prthex8:
	mov ax,sp
	mov bp,ax
	mov byte al, [bp+2]
	cmp al, 0
	jnz .nzero
		__prtch 30h
		
		mov ax,sp
		mov bp,ax
		mov byte al, [bp+3]		
		cmp al, FALSE
		je .end
			__prtch 30h
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
		__prtch dl
		pop dx
		pop cx	

		.dec:
	
		dec cl
		jmp .l1	
	.l2:
	
	pop ax
	
	.end:
	
	ret

proc_prtstr:
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
					
		__prtch al										
									
		pop si
		pop ds
											
		jmp .loop 
	.done:
	
	ret	
	
proc_prtch:
	mov ax,sp
	mov bp,ax

	mov al,[bp+2]
	mov ah,0Eh
	mov bh,00h
	int 10h	
	
	ret

proc_prtln:
	mov ah,03h
	mov bh,00h
	int 10h
	
	mov ah,02h
	inc dh
	mov dl,00h
	int 10h	
	
	ret
	
%endif