
%ifndef TUNIT_ASM
	%define TUNIT_ASM
	
	%include "lib/sys.mac"
	%include "lib/stdio.mac"

section .data
	
proc_testunit:
		
	mov ax,sp
	mov bp,ax
	
	mov byte [bp+2], TRUE
	
	mov word ds, [bp+7]
	mov word si, [bp+9]
			
	mov word cx, [si]
	add si,2
	mov byte bh, [si]
	inc si
	mov byte bl, [si]
	inc si
	mov byte dh, [si]
	inc si		
				
	sub cx,5						  
	.l1:
		cmp cx,0
		jle .l2
			
		push cx
		push dx
		push bx			
		push si
		push bp
		
		mov ax, [bp+3]						
		mov ds, ax				 
		mov di, [bp+5]
		
		mov ax, [bp+7]
			
		openstack 10h
		mov word [bp+1], ax
		mov word [bp+3], si
		mov byte [bp+5], bh
		xor ch,ch
		mov cl,bh
		add si,cx
		mov word [bp+6], ax
		mov word [bp+8], si
		mov byte [bp+0x0A], bl
		xor ch,ch
		mov cl,bl
		add si,cx
		mov word [bp+0x0B], ax
		mov word [bp+0x0D], si
		mov byte [bp+0x0F], dh
		call proc_printtc 						
		call di		
		newline
		push sp
		pop bp
		mov byte al, [bp]										 
		closestack 10h				
						
		pop bp	
		pop si	
		pop bx	
		pop dx
		pop cx
		
		cmp al,TRUE
		je .endok			
			mov byte [bp+2], FALSE
		.endok:
										
		xor ah,ah
		mov al,bh
		add al,bl
		add al,dh
		
		add si,ax									
		sub cx,ax									
		jmp .l1
	.l2:
		
	ret	
	
proc_printtc:
	mov ax,sp
	mov bp,ax
		
	mov dx,[bp+3]
	mov ax,[bp+5]
	mov bh,[bp+7]	
	
	push bp	
	printhex dx, ax, bh, TRUE	
	writechar 20h
	pop bp
	
	mov dx,[bp+8]
	mov ax,[bp+0x0A]
	mov bh,[bp+0x0C]	
	
	push bp
	printhex dx, ax, bh, TRUE  	
	writechar 20h
	pop bp
	
	mov dx,[bp+0x0D]
	mov ax,[bp+0x0F]
	mov bh,[bp+0x11]	
	push bp	
	printhex dx, ax, bh, TRUE
	writechar 20h	
	pop bp			
	
	ret
		
%endif