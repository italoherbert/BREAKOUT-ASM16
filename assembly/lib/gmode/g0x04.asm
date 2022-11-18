
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
	mov al,04h
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
		
	mov ax,0xB800
	mov es,ax		
	mov di,0
	
	mov cx,0
	.l1:	
		cmp cx,8000
		jae .l2
		
		lodsb		
		stosb
							
		inc cx
		jmp .l1
	.l2:
	
	add di,192
	.l3:	
		cmp cx,16000
		jae .l4
		
		lodsb		
		stosb
							
		inc cx
		jmp .l3
	.l4:	
					
	ret

proc_setpx:	
	mov ax,sp
	mov bp,ax
	
	mov ax,0x9000
	mov ds,ax	
	mov si,0
	
	mov ax,[bp+4]
	mov cx,ax

	shr ax,1
	mov bx,ax
	
	shl ax,1
	shl bx,3
	add ax,bx
	shl ax,3
	
	and cx,0x0001
	jz .endone
		add ax,8000
	.endone:
	
	add si,ax
	
	mov ax,[bp+2]
	mov dx,ax
	shr ax,2	
	and dx,0x03
	
	add si,ax
	
	mov bl,[bp+6]
	and bl,0x03
	
	cmp dx,3
	je .c3
	cmp dx,2
	je .c2
	cmp dx,1
	je .c1			
		mov al,[si]
		and al,0x3F
		shl bl,6
		or al,bl
		mov [si],al		
		jmp .endc
	.c1:
		mov al,[si]
		and al,0xCF
		shl bl,4
		or al,bl
		mov [si],al
		jmp .endc
	.c2:
		mov al,[si]
		and al,0xF3
		shl bl,2
		or al,bl
		mov [si],al
		jmp .endc
	.c3:
		mov al,[si]
		and al,0xFC
		or al,bl
		mov [si],al
	.endc:
	
	ret
	
%endif