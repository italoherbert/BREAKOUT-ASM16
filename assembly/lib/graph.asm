
%ifndef GRAPH_ASM
	%define GRAPH_ASM

	%include "lib/system.mac"
	%include "lib/math.mac"
	%include "lib/float.mac"
	%include "lib/trigon.mac"
	
	; depende da macro __setpx ( g0x*.mac )
		
%macro __drawstring 4
	__drawstring cs, %1, %2, %3, %4
%endmacro

%macro __drawstring 5
	stkopen 0x07
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov byte [bp+4],%3
	mov byte [bp+5],%4
	mov byte [bp+6],%5
	call proc_drawstring
	stkclose 0x07
%endmacro		
		
%macro __drawarc 10
	stkopen 0x0A
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4	
	mov byte [bp+8],%5
	mov byte [bp+9],%6
	call proc_drawarc
	stkclose 0x0A
%endmacro	

%macro __fillrect 5
	stkopen 0x09
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	mov byte [bp+8],%5
	call proc_fillrect
	stkclose 0x09
%endmacro	

%macro __drawrect 5
	stkopen 0x09
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	mov byte [bp+8],%5
	call proc_drawrect
	stkclose 0x09
%endmacro	

%macro __drawlineh 4
	stkopen 0x07
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov byte [bp+6],%4
	call proc_drawlineh	
	stkclose 0x07
%endmacro

%macro __drawlinev 4
	stkopen 0x07
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov byte [bp+6],%4
	call proc_drawlinev	
	stkclose 0x07
%endmacro

%macro __arc_quadcoords 8
	stkopen 0x10
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	call proc__arc_quadcoords
	push sp
	pop bp
	mov word %5, [bp+8]
	mov word %6, [bp+0x0A]
	mov word %7, [bp+0x0C]
	mov word %8, [bp+0x0E]	
	stkclose 0x10
%endmacro

%macro __x2dcoord 6
	stkopen 0x0C
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	call proc__x2dcoord
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	stkclose 0x0C
%endmacro

%macro __y2dcoord 6
	stkopen 0x0C
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	call proc__y2dcoord
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	stkclose 0x0C
%endmacro

%macro __arc_inc 4
	stkopen 0x0C
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc__arc_inc
	push sp
	pop bp
	mov word %3,[bp+4]
	mov word %4,[bp+6]
	stkclose 0x0C
%endmacro
		
section .data

proc_drawstring:		
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov ds,ax
	mov si,[bp+4]			

	mov dh,[bp+7]
	mov dl,[bp+6]
	mov ah,02h
	mov bh,0
	int 10h
		
	.l1:
		lodsb
		cmp al,0
		jz .l2
				
		mov ah,0Eh
		mov bh,0
		mov bl,[bp+8]	
		int 10h	
	
		jmp .l1
	.l2:	
		
	ret

proc_drawlineh:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov dl,[bp+8]
	
	.l1:
		cmp ax,cx
		ja .l2
		push ax
		push bx
		push cx
		push dx
		
		__setpx ax, bx, dl
				
		pop dx		
		pop cx
		pop bx
		pop ax
		inc ax
		jmp .l1
	.l2:
	
	ret
	

proc_drawlinev:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov dl,[bp+8]
	
	.l1:
		cmp bx,cx
		ja .l2
		push ax
		push bx
		push cx
		push dx
		
		__setpx ax, bx, dl
				
		pop dx		
		pop cx
		pop bx
		pop ax
		inc bx
		jmp .l1
	.l2:
	
	ret

proc_drawrect:
	mov ax,sp
	mov bp,ax		
	mov ax,[bp+2]
	mov bx,[bp+4]	
	mov cx,[bp+6]
	mov dl,[bp+0x0A]
	__drawlineh ax, bx, cx, dl
	
	mov ax,sp
	mov bp,ax		
	mov ax,[bp+2]
	mov bx,[bp+8]	
	mov cx,[bp+6]
	mov dl,[bp+0x0A]
	__drawlineh ax, bx, cx, dl
	
	mov ax,sp
	mov bp,ax		
	mov ax,[bp+2]
	mov bx,[bp+4]	
	mov cx,[bp+8]
	mov dl,[bp+0x0A]
	__drawlinev ax, bx, cx, dl
	
	mov ax,sp
	mov bp,ax		
	mov ax,[bp+6]
	mov bx,[bp+4]	
	mov cx,[bp+8]
	mov dl,[bp+0x0A]
	__drawlinev ax, bx, cx, dl
	
	ret

proc_fillrect:
	mov ax,sp
	mov bp,ax	
	
	mov ax,[bp+2]
	mov bx,[bp+4]	
	mov cx,[bp+6]
	mov dx,[bp+8]
			
	.l1:			
		cmp bx,dx
		ja .l2
		stkpush ax, bx, cx, dx, bp
		
		mov dl,[bp+0x0A]
		__drawlineh ax, bx, cx, dl
		
		stkpop ax, bx, cx, dx, bp		
		inc bx				
		jmp .l1	
	.l2:
		
	ret

proc_drawarc:	
	mov ax,sp
	mov bp,ax
		
	mov ax,[bp+6]
	__int16tofl ax, ax, bx
	__arc_inc ax, bx, ax, bx
	push ax
	push bx
	
	mov cx,0	; angulo (alta)
	mov dx,0	; angulo (baixa)		
	push cx
	push dx
	.l1:					
		mov ax,0x3FC9	; PI/2 (alta)
		mov bx,0x0FDB	; PI/2 (baixa)	
		__flcmp cx, dx, ax, bx, cl
		cmp cl,0
		jg .l2
		
		mov ax,sp
		mov bp,ax
		add bp,8
		
		push bp				
		mov ax,[bp+8]			; raio (int16)		
		__int16tofl ax, ax, bx	; raio (float)
		pop bp		
		
		pop dx
		pop cx
		push cx
		push dx
		push bp		
		__y2dcoord ax, bx, cx, dx, ax, bx				
		__fltoint16 ax, bx, ax	; y (int160)
		pop bp
		
		pop dx
		pop cx	
		push cx
		push dx	
		push ax
		push bp
		push cx
		push dx
		
		mov ax,[bp+6]			; raio (int16)
		__int16tofl ax, ax, bx	; raio (float)
		pop dx
		pop cx		
		__x2dcoord ax, bx, cx, dx, ax, bx				
		__fltoint16 ax, bx, cx	; x (int16)
		pop bp
		
		pop dx
		mov ax,[bp+2]
		mov cx,[bp+4]
			
		push bp				
		__arc_quadcoords ax, bx, cx, dx, ax, bx, cx, dx
		pop bp
		
		stkpush ax, bx, cx, dx, bp
		
		mov dl,[bp+0x0A]				
		cmp byte [bp+0x0B],0
		jnz .fill1
			push bx
			push cx
			push dx			
			__setpx ax, bx, dl
			pop dx
			pop cx
			pop bx
			__setpx cx, bx, dl
			jmp .endfill1
		.fill1:
			cmp ax,cx
			jae .endfill1	
			stkpush ax, bx, cx, dx
			__setpx ax, bx, dl
			stkpop ax, bx, cx, dx			
			inc ax
			jmp .fill1
		.endfill1:
		
		stkload ax, bx, cx, dx, bp
		
		mov bl,[bp+0x0A]				
		cmp byte [bp+0x0B],0
		jnz .fill2
			push bx
			push cx
			push dx			
			__setpx ax, dx, bl
			pop dx
			pop cx
			pop bx
			__setpx cx, dx, bl
			jmp .endfill2
		.fill2:
			cmp ax,cx
			jae .endfill2	
			stkpush ax, bx, cx, dx
			__setpx ax, dx, bl
			stkpop ax, bx, cx, dx			
			inc ax
			jmp .fill2
		.endfill2:
		
		stkpop ax, bx, cx, dx, bp 		
																		
		pop dx
		pop cx
		pop bx
		pop ax
		push ax
		push bx
		__fladd cx, dx, ax, bx, cx, dx
		pop bx
		pop ax
		push ax
		push bx
		push cx
		push dx					
		
		jmp .l1
	.l2:
														
	pop dx
	pop cx
	pop bx
	pop ax
	
	ret
		
proc__arc_quadcoords:
	mov ax,sp
	mov bp,ax
	
	mov ax,0xFFFF
	sub ax,[bp+4]
	inc ax
	add ax,[bp+2]	
	mov [bp+0x0A], ax
	
	mov ax,[bp+8]
	add ax,[bp+6]
	mov [bp+0x0C], ax
	
	mov ax,[bp+4]
	add ax,[bp+2]
	mov [bp+0x0E], ax
	
	mov ax,0xFFFF
	sub ax,[bp+8]
	inc ax
	add ax,[bp+6]
	mov [bp+0x10], ax
	
	ret
		
proc__x2dcoord:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+6]	; angulo (alta)
	mov bx,[bp+8]	; angulo (baixa)
	
	__cos0x90 ax,bx,ax,bx
	
	mov cx,sp
	mov bp,cx
	mov cx,[bp+2]	; raio (alta)
	mov dx,[bp+4]	; raio (baixa)
	
	__flmul ax, bx, cx, dx, ax, bx
	
	mov cx,sp
	mov bp,cx
	mov [bp+0x0A],ax
	mov [bp+0x0C],bx
			
	ret
	
proc__y2dcoord:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+6]	; angulo (alta)
	mov bx,[bp+8]	; angulo (baixa)
	
	__sin0x90 ax,bx,ax,bx
	
	mov cx,sp
	mov bp,cx
	mov cx,[bp+2]	; raio (alta)
	mov dx,[bp+4]	; raio (baixa)
	
	__flmul ax, bx, cx, dx, ax, bx
	
	mov cx,sp
	mov bp,cx
	mov [bp+0x0A],ax
	mov [bp+0x0C],bx
			
	ret
	
proc__arc_inc:
	mov ax,sp
	mov bp,ax
			
	mov ax,[bp+2]
	mov bx,[bp+4]
	push bp
	__flshr ax,1	; divide por 2
	pop bp
	
	mov cx,0x4049	; PI (alta)
	mov dx,0x0FDB	; PI (baixa)
	
	push bp
	__flmul ax, bx, cx, dx, ax, bx
	pop bp
	
	mov cx,0x3FC9
	mov dx,0x0FDB
	
	push bp
	__fldiv cx, dx, ax, bx, ax, bx
	pop bp
	
	mov [bp+6], ax
	mov [bp+8], bx
	
	ret
	
%endif