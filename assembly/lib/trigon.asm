
%ifndef TRIGON_ASM
	%define TRIGON_ASM

	%include "lib/system.mac"
	%include "lib/math.mac"
	%include "lib/float.mac"

%macro __sin 4
	__sinorcos %1, %2, %3, %4, 1
%endmacro

%macro __cos 4
	__sinorcos %1, %2, %3, %4, 0
%endmacro

%macro __sin0x90 4
	__sinorcos0x90 %1, %2, %3, %4, 1
%endmacro

%macro __cos0x90 4
	__sinorcos0x90 %1, %2, %3, %4, 0
%endmacro

%macro __to0x360 4
	stkopen 0x04
	mov word [bp+0],%1
	mov word [bp+2],%2	
	call proc_to0x360
	push sp
	pop bp
	mov word %3,[bp+4]
	mov word %4,[bp+6]
	stkclose 0x04
%endmacro

%macro __toradians 4
	stkopen 0x08
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc_toradians
	push sp
	pop bp
	mov word %3, [bp+4]
	mov word %4, [bp+6]
	stkclose 0x08
%endmacro

%macro __todegrees 4
	stkopen 0x08
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc_todegrees
	push sp
	pop bp
	mov word %3, [bp+4]
	mov word %4, [bp+6]
	stkclose 0x08
%endmacro

%macro __atan 4
	stkopen 0x08
	mov word [bp+0],%1
	mov word [bp+2],%2	
	call proc_atan
	push sp
	pop bp
	mov word %3,[bp+4]
	mov word %4,[bp+6]
	stkclose 0x08
%endmacro

%macro __sinorcos 5
	stkopen 0x09
	mov word [bp+0],%1
	mov word [bp+2],%2	
	mov byte [bp+8],%5
	call proc_sinorcos
	push sp
	pop bp
	mov word %3,[bp+4]
	mov word %4,[bp+6]
	stkclose 0x09
%endmacro

%macro __sinorcos0x90 5
	stkopen 0x09
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov byte [bp+8],%5
	call proc_sinorcos0x90
	push sp
	pop bp
	mov word %3,[bp+4]
	mov word %4,[bp+6]
	stkclose 0x09
%endmacro

%macro __sinnorm 3
	stkopen 0x06
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc__sinnorm
	push sp
	pop bp
	mov word %1,[bp+0]
	mov word %2,[bp+2]
	mov word %3,[bp+4]
	stkclose 0x06
%endmacro

%macro __cosnorm 3
	stkopen 0x06
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc__cosnorm
	push sp
	pop bp
	mov word %1,[bp+0]
	mov word %2,[bp+2]
	mov word %3,[bp+4]
	stkclose 0x06
%endmacro

%macro __norm_factors 5
	stkopen 0x0A
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc__norm_factors
	push sp
	pop bp
	mov word %3,[bp+4]
	mov word %4,[bp+6]
	mov word %5,[bp+8]
	stkclose 0x0A
%endmacro

%macro __fat16 2
	stkopen 0x04
	mov word [bp+0],%1
	call proc__fat16
	push sp
	pop bp
	mov word %2, [bp+2]
	stkclose 0x04
%endmacro

%macro __pow16 3
	stkopen 0x06
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc__pow16
	push sp
	pop bp
	mov word %3, [bp+4]
	stkclose 0x06
%endmacro
	
section .data
	PI: dd 0x40490FDB
	__180dg: dd 0x43340000

proc_to0x360:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	and ax,0x7FFF
	
	mov cx,0x40C9	; 2*PI (alta)
	mov dx,0x0FDB	; 2*PI (baixa)		
		
	push bp
	__fldiv ax, bx, cx, dx, cx, dx
	__fltoint32 cx, dx, cx, dx
	__int32tofl cx, dx, cx, dx
	pop bp
		
	mov ax,0x40C9	; 2*PI (alta)
	mov bx,0x0FDB	; 2*PI (baixa)
	push bp
	__flmul ax, bx, cx, dx, cx, dx
	pop bp				
		
	mov ax,[bp+2]
	mov bx,[bp+4]		
	and ax,0x7FFF		
	push bp	
	__flsub ax, bx, cx, dx, ax, bx
	pop bp	
	
	mov cx,[bp+2]
	and cx,0x8000
	cmp cx,0
	jz .endneg
		mov cx,0x40C9	; 2*PI (alta)
		mov dx,0x0FDB	; 2*PI (baixa)
		push bp		
		__flsub cx, dx, ax, bx, ax, bx		
		pop bp	
	.endneg:	
	
	mov [bp+6],ax
	mov [bp+8],bx	
							
	ret
	
proc_toradians:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]		
	mov cx,0x4049
	mov dx,0x0FDB
	__flmul ax, bx, cx, dx, ax, bx
	mov cx,0x4334
	mov dx,0x0000	
	__fldiv ax, bx, cx, cx, ax, bx
	
	mov cx,sp
	mov bp,cx
	mov [bp+6],ax
	mov [bp+8],bx
	
	ret
	
proc_todegrees:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]		
	mov cx,0x4334
	mov dx,0x0000
	__flmul ax, bx, cx, dx, ax, bx		
	mov cx,0x4049
	mov dx,0x0FDB	
	__fldiv ax, bx, cx, cx, ax, bx
	
	mov cx,sp
	mov bp,cx
	mov [bp+6],ax
	mov [bp+8],bx
	
	ret

proc_sinorcos:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	cmp byte [bp+0x0A],0
	jz .normcos
		__sinnorm ax, bx, cx
		jmp .endnorm
	.normcos:
		__cosnorm ax, bx, cx	
	.endnorm:
	
	push cx
	
	mov cx,sp
	mov bp,cx
	add bp,2
	mov cl,[bp+0x0A]	
	__sinorcos0x90 ax, bx, ax, bx, cl
	mov cx,sp
	mov bp,cx
	add bp,2	
	mov [bp+6],ax
	mov [bp+8],bx
			
	pop cx
		
	mov dx,sp
	mov bp,dx
		
	cmp cx,0x8000
	je .one
		and word [bp+6],cx
		jmp .endcmp
	.one:
		or word [bp+6],cx	
	.endcmp:
	
	ret
	
proc_sinorcos0x90:
	mov cx,sp
	mov bp,cx

	mov word [bp+6],0
	mov word [bp+8],0		
	
	mov cx,0
	.l1:
		cmp cx,0x03
		ja .l2		
		push cx
		
		and cx,0x0001
		cmp cx,0
		jnz .neg
			mov ax,0x0001
			jmp .endneg
		.neg:
			mov ax,0xFFFF
		.endneg:
				
		pop cx
		push cx
		push ax
		
		mov dx,0
		mov ax,2
		mul cx
		
		mov dx,sp
		mov bp,dx
		add bp,4		
		cmp byte [bp+0x0A],0
		jz .incremented
			inc ax
		.incremented:
						
		__fat16 ax, dx
						
		pop ax
		push dx	
		__int16to32 ax, cx, dx						
		__int32tofl cx, dx, ax, bx
		
		pop cx
		push ax
		push bx		
		__int16to32 cx, ax, bx
		__int32tofl ax, bx, cx, dx
		
		pop bx
		pop ax
		
		__fldiv ax, bx, cx, dx, ax, bx
						
		pop cx
		push cx
		push ax
		push bx
		
		mov ax,sp
		mov bp,ax
		add bp,6
		
		mov dx,0
		mov ax,2
		mul cx
				
		cmp byte [bp+0x0A],0
		jz .incremented2
			inc ax
		.incremented2:
				
		mov cx,ax														
		
		mov ax,0x3F80
		mov bx,0
		
		.l1.1:
			cmp cx,0
			jz .l1.2
			push cx
			
			mov cx,[bp+2]
			mov dx,[bp+4]
			push bp	
			__flmul ax, bx, cx, dx, ax, bx
			pop bp	
							
			pop cx
			dec cx
			jmp .l1.1
		.l1.2: 
					
		pop dx
		pop cx
		
		__flmul ax, bx, cx, dx, ax, bx
						
		mov cx,sp
		mov bp,cx
		add bp,2
		
		mov cx,[bp+6]
		mov dx,[bp+8]
		push bp
		__fladd ax, bx, cx, dx, ax, bx		
		pop bp			
		mov [bp+6],ax
		mov [bp+8],bx
				
		pop cx
		inc cx
		jmp .l1
	.l2:			
	
	ret
	

proc_atan:
	mov ax,sp
	mov bp,ax 

	mov word [bp+6],0
	mov word [bp+8],0		
	
	mov cx,0
	.l1:
		cmp cx,0x03
		ja .l2		
		push cx
		
		shl cx,1
		inc cx
		push cx
								
		mov ax,0x3F80	; 1.0 (alta)
		mov bx,0x0000	; 1.0 (baixa)				
		.l1.1:
			cmp cx,0
			jz .l1.2
			push cx
			
			mov cx,[bp+2]
			mov dx,[bp+4]
			push bp	
			__flmul ax, bx, cx, dx, ax, bx
			pop bp	
							
			pop cx
			dec cx
			jmp .l1.1
		.l1.2:			
		
		pop cx	
		push ax
		push bx
				
		push bp
		__int16tofl cx, cx, dx
		pop bp
		
		pop bx
		pop ax
		
		push bp	
		__fldiv ax, bx, cx, dx, ax, bx
		pop bp
				
		pop cx
		push cx		
		and cx,0x0001
		cmp cx,0
		jz .endneg
			mov cx,ax	
			or cx, 0x0000
			not cx
			and cx,0x8000								
			and ax,0x7FFF			
			add ax,cx
		.endneg:
				
		mov cx,[bp+6]
		mov dx,[bp+8]
		push bp		
		__fladd ax, bx, cx, dx, ax, bx
		pop bp
		mov [bp+6], ax
		mov [bp+8], bx
				
		pop cx
		inc cx
		jmp .l1
	.l2:
		
	ret
	
proc__fat16:
	mov ax,sp
	mov bp,ax
	
	mov cx,1
	mov word [bp+4], 1
	.l1:
		cmp word cx,[bp+2]
		ja .l2
		
		xor dx,dx
		mov ax,[bp+4]
		imul cx
		
		mov [bp+4],ax
		
		inc cx
		jmp .l1
	.l2:
	
	ret
		
proc__pow16:
	mov ax,sp
	mov bp,ax
	
	mov cx,[bp+4]
	mov word [bp+6], 1	
	.l1:
		cmp cx,0
		jz .l2
		
		xor dx,dx
		mov ax,[bp+2]
		imul word [bp+6]
		
		mov [bp+6],ax
		
		dec cx
		jmp .l1
	.l2:
		
	ret
	
proc__sinnorm:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	
	__norm_factors ax, bx, ax, bx, cx

	push cx	; factor (phi/PI)
		
	mov cx,0x3FC9 ; PI/2 (high)
	mov dx,0x0FDB ; PI/2 (low)
	
	push ax
	push bx
	__cmp32 ax, bx, cx, dx, cl
	pop bx
	pop ax
	cmp cl,0
	jle .l1
		mov cx,0x4049 ; PI (high)
		mov dx,0x0FDB ; PI (low)
		__flsub cx, dx, ax, bx, ax, bx				
	.l1:
				
	pop cx

	mov dx,sp
	mov bp,dx
	mov dx,[bp+2]
	and dx,0x8000
		
	cmp dx,0
	jge .l2
		inc cx		
	.l2:	
			
	mov dx,0x7FFF
	and cx,0x0001
	cmp cx,0
	jz .l3
		mov dx,0x8000
	.l3:
					
	mov [bp+2],ax
	mov [bp+4],bx
	mov [bp+6],dx
	
	ret	
	
proc__cosnorm:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	
	__norm_factors ax, bx, ax, bx, cx

	push cx		; fator2 (phi/PI)
	
	mov cx,0x3FC9 ; PI/2 (high)
	mov dx,0x0FDB ; PI/2 (low)
		
	push ax
	push bx
	__cmp32 ax, bx, cx, dx, cl
	pop bx
	pop ax
		
	push cx
	cmp cl,0
	jle .l1
		mov cx,0x4049 ; PI (high)
		mov dx,0x0FDB ; PI (low)
		__flsub cx, dx, ax, bx, ax, bx	
	.l1:
						
	pop cx	; quadrante2 (true, false)
	pop dx	; fator2 (phi/PI)

	push sp
	pop bp		
	mov [bp+2],ax	
	mov [bp+4],bx
	
	mov ax,0x7FFF
	
	and dx,0x0001
	cmp dx,0
	jnz .fimpar
		cmp cl,0
		jl .endf		
			mov ax,0x8000			
		jmp .endf
	.fimpar:		
		cmp cl,0
		jge .endf
			mov ax,0x8000
	.endf:		
						
	mov word [bp+6],ax
	
	ret
	
proc__norm_factors: ; f1=(phi%PI) --> float 32bits, f2=(phi/PI) --> int 16bits
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]	
	and ax,0x7FFF
		
	mov cx,0x4049 ; PI (high)
	mov dx,0x0FDB ; PI (low)

	push bp
	__fldiv ax, bx, cx, dx, ax, bx		
	__fltoint16 ax, bx, ax
	pop bp
		
	push ax		; fator
		
	push bp
	__int16tofl	ax, ax, bx	
	
	mov cx,0x4049 ; PI (high)
	mov dx,0x0FDB ; PI (low)
	__flmul ax, bx, cx, dx, ax, bx		
	pop bp
	
	mov cx,[bp+2]
	mov dx,[bp+4]
	and cx,0x7FFF
		
	__flsub cx, dx, ax, bx, ax, bx 			; theta -> ax bx
	
	pop cx				
		
	mov dx,sp
	mov bp,dx	
	mov [bp+6],ax
	mov [bp+8],bx
	mov [bp+0x0A],cx
		
	ret
	
%endif