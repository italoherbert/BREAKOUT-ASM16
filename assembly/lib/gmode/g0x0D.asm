
%ifndef G0x0D_ASM
	%define G0x0D_ASM

	%include "lib/system.mac"
	
%macro __width 1
	stkopen 0x02
	call proc_width
	push sp
	pop bp
	mov word %1, [bp+2]
	stkclose 0x02	
%endmacro

%macro __height 1
	stkopen 0x02
	call proc_height
	push sp
	pop bp
	mov word %1, [bp+2]
	stkclose 0x02	
%endmacro

%macro __setpx 3
	stkopen 0x05
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov byte [bp+4],%3
	call proc_setpx	
	stkclose 0x05
%endmacro				
				
section .data

proc_initgraph:	
	mov ah,00h
	mov al,0Dh
	int 10h
					
	ret
		
proc_closegraph:
	mov ah,00h
	mov al,03h
	int 10h
	
	ret
	
proc_width:
	mov ax,sp
	mov bp,ax
	mov word [bp+2],320
	
	ret	

proc_height:
	mov ax,sp
	mov bp,ax
	mov word [bp+2],200
			
	ret
	
proc_repaint:
	mov ax,0x9000
	mov ds,ax
	mov si,0
		
	mov dx,0x03CE
	mov ax,0x0005
	out dx,ax
		
	mov di,0
	.l1:	
		cmp di,8000
		jae .l2
		
		mov bh,[si+0]
		mov bl,[si+1]
		mov ch,[si+2]
		mov cl,[si+3]
		add si,4

		push ds
	
		mov ax,0xA000
		mov ds,ax
		
		mov dx,0x03C4
		mov ax,0x0102		
		out dx,ax
		mov [di],bh
		
		mov dx,0x03C4
		mov ax,0x0202		
		out dx,ax
		mov [di],bl
		
		mov dx,0x03C4
		mov ax,0x0402		
		out dx,ax
		mov [di],ch
		
		mov dx,0x03C4
		mov ax,0x0802		
		out dx,ax
		mov [di],cl
		
		pop ds
		
		inc di
		jmp .l1
	.l2:		
		
	mov dx,0x03C4
	mov ax,0x0F02
	out dx,ax					
								
	ret

proc_setpx:	
	mov ax,sp
	mov bp,ax
	
	mov ax,0x9000
	mov ds,ax	
	mov si,0
	
	mov ax,[bp+4]
	mov bx,ax
	
	shl ax,1
	shl bx,3
	add ax,bx
	shl ax,4
		
	add si,ax
	
	mov ax,[bp+2]	
	mov cx,ax
	shr ax,3
	shl ax,2
	and cx,0x07
		
	add si,ax
		
	mov dl,[bp+6]
	shl dl,4
	mov ah,dl
	mov al,dl
	mov bh,dl
	mov bl,dl
	
	and ah,0x10
	and al,0x20
	and bh,0x40
	and bl,0x80
	mov dh,0x80
	shl ah,3
	shl al,2
	shl bh,1
	shr ah,cl
	shr al,cl
	shr bh,cl
	shr bl,cl
	shr dh,cl
	not dh
	
	mov cl,[si]
	and cl,dh
	add cl,ah
	mov [si],cl
	inc si
	
	mov cl,[si]
	and cl,dh
	add cl,al
	mov [si],cl
	inc si
	
	mov cl,[si]
	and cl,dh
	add cl,bh
	mov [si],cl
	inc si
	
	mov cl,[si]
	and cl,dh
	add cl,bl
	mov [si],cl
				
	ret
	
%endif