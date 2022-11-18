
%ifndef G0x13_ASM
	%define G0x13_ASM

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
	mov ax,sp
	mov bp,ax
	
	mov ah,00h
	mov al,13h
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

	mov ax,0xA000
	mov es,ax
	mov di,0	
	
	mov cx,0
	.l1:
		cmp cx,64000
		jae .l2
		push cx
				
		lodsb
		stosb
		
		pop cx
		inc cx
		jmp .l1
	.l2:
					
	ret

proc_setpx:
	mov ax,sp
	mov bp,ax
	
	mov cx,[bp+2]
	mov dx,[bp+4]
	mov ax,[bp+4]
		
	shl dx,1		
	shl ax,3		
	add dx,ax			
	shl dx,5
			 	
	add cx,dx
		
	mov ax,0x9000	
	mov ds,ax
	mov si,cx
	mov al,[bp+6]
	mov byte [si],al
	
	ret
	
%endif