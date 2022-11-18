
%ifndef BASIC_ASM
	%define BASIC_ASM
		
section .data

proc_prtstr:
	mov ax,sp
	mov bp,ax
	
	mov word ax,[bp+2]
	mov ds,ax
	mov word si,[bp+4]
	
	.l1:
		lodsb
		cmp al,0
		jz .l2
		
		mov ah,0Eh
		mov bh,0
		int 10h
			
		jmp .l1
	.l2:
	
	ret
	
proc_prthex16:
	mov ax,sp
	mov bp,ax	
	mov al,[bp+3]
	push ax
	call proc_prthex8
	pop ax
		
	mov ax,sp
	mov bp,ax
	mov al,[bp+2]
	push ax
	call proc_prthex8
	pop ax
	ret
	
proc_prthex8:
	mov ax,sp
	mov bp,ax
				
	mov al,[bp+2]
	shr al,4
	cmp al,0Ah		
	jb .nsum1
		add al,07h
	.nsum1:
	add al,30h
	mov ah,0Eh
	mov bh,0
	int 10h
	
	
	mov al,[bp+2]
	shl al,4
	shr al,4
	cmp al,0Ah
	jb .nsum2
		add al,07h
	.nsum2:
	add al,30h
	mov ah,0Eh
	mov bh,0
	int 10h	
	
	ret
			
proc_prtln:
	mov ah,03h
	mov bh,0
	int 10h
	
	mov ah,02h
	mov bh,0
	add dh,1
	mov dl,0
	int 10h
	
	ret
	
%endif