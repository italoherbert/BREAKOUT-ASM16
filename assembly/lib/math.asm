
%ifndef MATH_ASM
	%define MATH_ASM

	%include "lib/system.mac"

%macro __int16to32 3
	stkopen 0x06
	mov word [bp+0],%1
	call proc_int16to32
	push sp
	pop bp
	mov word %2, [bp+2]
	mov word %3, [bp+4]
	stkclose 0x06
%endmacro

%macro __int32to16 3
	stkopen 0x06
	mov word [bp+0], %1
	mov word [bp+2], %2
	call proc_int32to16
	push sp
	pop bp
	mov word %3, [bp+4]
	stkclose 0x06
%endmacro

%macro __add32 6
	stkopen 0x0C
	mov word [bp+0], %1
	mov word [bp+2], %2
	mov word [bp+4], %3
	mov word [bp+6], %4	
	call proc_add32
	push sp
	pop bp
	mov word %5, [bp+8]
	mov word %6, [bp+0x0A]
	stkclose 0x0C
%endmacro

%macro __sub32 6
	stkopen 0x0C
	mov word [bp+0], %1
	mov word [bp+2], %2
	mov word [bp+4], %3
	mov word [bp+6], %4	
	call proc_sub32
	push sp
	pop bp
	mov word %5, [bp+8]
	mov word %6, [bp+0x0A]
	stkclose 0x0C
%endmacro

%macro __mul32 6
	stkopen 0x0C
	mov word [bp+0], %1
	mov word [bp+2], %2
	mov word [bp+4], %3
	mov word [bp+6], %4	
	call proc_mul32
	push sp
	pop bp
	mov word %5, [bp+8]
	mov word %6, [bp+0x0A]
	stkclose 0x0C
%endmacro

%macro __div32 9
	stkopen 0x11
	mov word [bp+0], %1
	mov word [bp+2], %2
	mov word [bp+4], %3
	mov word [bp+6], %4
	mov word [bp+8], %5
	mov word [bp+0x0A], %6	
	call proc_div32
	push sp
	pop bp
	mov word %7, [bp+0x0C]
	mov word %8, [bp+0x0E]
	mov byte %9, [bp+0x10]
	stkclose 0x11
%endmacro

%macro __cmp32 5
	stkopen 9
	mov word [bp+0], %1
	mov word [bp+2], %2
	mov word [bp+4], %3
	mov word [bp+6], %4
	call proc_cmp32
	push sp
	pop bp
	mov byte %5, [bp+8]
	stkclose 9	
%endmacro

%macro __shl32 3
	stkopen 5
	mov word [bp+0], %1
	mov word [bp+2], %2
	mov byte [bp+4], %3
	call proc_shl32
	push sp
	pop bp
	mov word %1, [bp+0]
	mov word %2, [bp+2]
	stkclose 5
%endmacro

%macro __shr32 3
	stkopen 5
	mov word [bp+0], %1
	mov word [bp+2], %2
	mov byte [bp+4], %3
	call proc_shr32
	push sp
	pop bp
	mov word %1, [bp+0]
	mov word %2, [bp+2]
	stkclose 5
%endmacro

%macro __lzcount32 3	
	push %2		
	__lzcount16 %1, cl	
	pop ax
	cmp cl,4
	jb .end
		push cx		
		__lzcount16 ax, al		
		pop cx
		add cl,al
	.end:	
	mov byte %3, cl 
%endmacro

%macro __lzcount16 2
	stkopen 3
	mov word [bp+0], %1
	call proc__lzcount16
	push sp
	pop bp
	mov byte %2, [bp+2]	
	stkclose 3
%endmacro

%macro __lzbitcount32 3	
	push %2		
	__lzbitcount16 %1, cl
	pop ax
	cmp cl,16
	jb .end
		push cx		
		__lzbitcount16 ax, al		
		pop cx
		add cl,al
	.end:	
	mov byte %3, cl 
%endmacro
		
%macro __lzbitcount16 2
	stkopen 3
	mov word [bp+0], %1
	call proc__lzbitcount16
	push sp
	pop bp
	mov byte %2, [bp+2]	
	stkclose 3
%endmacro	

%macro __calc_dividendo1 7
	stkopen 0x0D
	mov word [bp+0], %1
	mov word [bp+2], %2
	mov word [bp+4], %3
	mov word [bp+6], %4
	call proc_calc_dividendo1
	push sp
	pop bp
	mov word %5, [bp+0x08]
	mov word %6, [bp+0x0A]
	mov byte %7, [bp+0x0C]
	stkclose 0x0D
%endmacro

%macro __calc__prox_dividendo 5
	stkopen 9
	mov word [bp+0], %1
	mov word [bp+2], %2
	mov word [bp+4], %3
	mov word [bp+6], %4
	mov word [bp+8], %5
	call proc_calc_prox_dividendo
	push sp
	pop bp
	mov word %3, [bp+4]
	mov word %4, [bp+6]
	mov byte %5, [bp+8]
	stkclose 9
%endmacro
				
section .data

proc_int16to32:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov [bp+6],ax
				
	and ax,0x8000
	cmp ax,0
	jnz .one
		mov word [bp+4],0			
		jmp .endcmp
	.one:				
		mov word [bp+4],0xFFFF
	.endcmp:
	
	ret
	
proc_int32to16:
	mov ax,sp
	mov bp,ax
		
	mov ax,[bp+4]
	and ax,0x7FFF
	mov [bp+6],ax
	
	mov ax,[bp+2]
	and ax,0x8000
	add [bp+6],ax
		
	ret

proc_idiv32:
	stkopen 0x11
	mov ax,[bp+0x13]
	and ax,0x7FFF
	mov [bp+0],ax
	mov ax,[bp+0x15]
	mov [bp+2],ax
	mov ax,[bp+0x17]
	and ax,0x7FFF
	mov [bp+4],ax
	mov ax,[bp+0x19]
	mov [bp+6],ax 
	call proc_div32
	mov ax,sp
	mov bp,ax
	mov ax,[bp+8]
	mov [bp+0x1B], ax
	mov ax,[bp+0x0A]
	mov [bp+0x1D], ax
	mov ax,[bp+0x0C]
	mov [bp+0x1F], ax
	mov ax,[bp+0x0E]
	mov [bp+0x21], ax
	mov al,[bp+0x10]
	mov byte [bp+0x23], al
	stkclose 0x11
	
	push sp
	pop bp
		
	mov cx,[bp+2]
	mov dx,[bp+6]
	and cx,0x8000
	and dx,0x8000
	xor cx,dx
	
	cmp word [bp+0x0A],0
	jnz .signal1
	cmp word [bp+0x0C],0
	jz .endsignal1
	.signal1:
		add word [bp+0x0A],cx
	.endsignal1:
	
	cmp word [bp+0x0E],0
	jnz .signal2
	cmp word [bp+0x10],0
	jz .endsignal2
	.signal2:
		add word [bp+0x0E],cx	
	.endsignal2:
		
	ret	

proc_imul32:		
	stkopen 0x0C
	mov ax,[bp+0x0E]
	and ax,0x7FFF
	mov [bp+0],ax
	mov ax,[bp+0x10]
	mov [bp+2],ax
	mov ax,[bp+0x12]
	and ax,0x7FFF
	mov [bp+4],ax
	mov ax,[bp+0x14]
	mov [bp+6],ax 
	call proc_mul32
	mov ax,sp
	mov bp,ax
	mov ax,[bp+8]
	mov bx,[bp+0x0A]
	stkclose 0x0C
	
	mov cx,sp
	mov bp,cx		
		
	mov [bp+0x0A],ax
	mov [bp+0x0C],bx
	
	cmp word [bp+0x0A],0
	jnz .signal1
	cmp word [bp+0x0C],0
	jz .endsignal1
	.signal1:
		mov cx,[bp+2]
		mov dx,[bp+6]
		and cx,0x8000
		and dx,0x8000
		xor cx,dx
		add word [bp+0x0A],cx
	.endsignal1:
	
	ret

proc_div32:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+6]
	add ax,[bp+8]
	cmp ax,0
	jz .divbyzero
	
	cmp word [bp+2], 0
	jnz .div2
	cmp word [bp+6], 0
	jnz .div2
		xor dx,dx
		mov ax, [bp+4]
		div word [bp+8]
		mov word [bp+0x0A], 0
		mov word [bp+0x0C], ax
		mov word [bp+0x0E], 0
		mov word [bp+0x10], dx
		jmp .enddiv
	.div2:
		mov ax,[bp+2]
		cmp ax,[bp+6]
		jb .qzero
		ja .div
		mov ax,[bp+4]
		cmp ax,[bp+8]
		jb .qzero
		
		.div:
		
		mov word [bp+0x0A], 0
		mov word [bp+0x0C], 0		
		mov word [bp+0x0E], 0
		mov word [bp+0x10], 0
		
		mov ax,[bp+2]
		mov bx,[bp+4]
		mov cx,[bp+6]
		mov dx,[bp+8]		
		__calc_dividendo1 ax, bx, cx, dx, ax, bx, cl

		mov dx,sp
		mov bp,dx
		mov word [bp+0x0E], ax
		mov word [bp+0x10], bx
		
		push cx
		.l1:							
			mov dx,sp
			mov bp,dx		
			add bp,2
			mov ax, [bp+0x0E]
			mov bx, [bp+0x10]
			mov cx, [bp+6]
			mov dx, [bp+8]
			__cmp32 ax, bx, cx, dx, cl
			
			push cx
			mov dx,sp
			mov bp,dx
			add bp,4
			mov ax,[bp+0x0A]
			mov bx,[bp+0x0C]
			push bp
			__shl32 ax, bx, 1
			pop bp				
			pop cx	
									
			cmp cl,0
			jl .l11
				add bx,1
				adc ax,0	
				
				mov cx,[bp+6]
				mov dx,[bp+8]
				sub [bp+0x10],dx
				sbb [bp+0x0E],cx							
			.l11:							
			mov word [bp+0x0A], ax
			mov word [bp+0x0C], bx					
					
			pop cx
			push cx												
			
			cmp cl,32
			jae .l2
						
			pop cx
			stkopen 9
			mov ax,[bp+0x0B]
			mov word [bp+0], ax
			mov ax,[bp+0x0D]
			mov word [bp+2], ax
			mov ax,[bp+0x17]
			mov word [bp+4], ax
			mov ax,[bp+0x19]
			mov word [bp+6], ax
			mov byte [bp+8], cl
			call proc_calc_prox_dividendo
			mov ax,sp
			mov bp,ax
			mov word ax,[bp+4]
			mov word bx,[bp+6]
			mov byte cl,[bp+8] 
			stkclose 9
			mov dx,sp
			mov bp,dx
			mov [bp+0x0E],ax
			mov [bp+0x10],bx
			push cx
			jmp .l1
		.l2:	
		pop cx
			
		jmp .enddiv
	.qzero:
		mov word [bp+0x0A], 0
		mov word [bp+0x0C], 0
		mov ax,[bp+2]
		mov word [bp+0x0E], ax
		mov ax,[bp+4]
		mov word [bp+0x10], ax	
	.enddiv:
		mov byte [bp+0x12], 0
		jmp .end
	.divbyzero:
		mov byte [bp+0x12], 1						
	.end:		
			
	ret
		
proc_mul32:
	mov ax,sp
	mov bp,ax
	
	xor dx,dx
	mov ax,[bp+4]
	mul word [bp+8]
	
	mov word [bp+0x0A], dx
	mov word [bp+0x0C], ax	
	
	xor dx,dx
	mov ax,[bp+4]
	mul word [bp+6]
		
	add word [bp+0x0A],ax
	
	xor dx,dx
	mov ax,[bp+2]
	mul word [bp+8]
	
	add word [bp+0x0A],ax
	
	ret

proc_add32:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov dx,[bp+8]
	
	add bx,dx
	adc ax,cx
	
	mov [bp+0x0A],ax
	mov [bp+0x0C],bx	
	
	ret
	
proc_sub32:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov dx,[bp+8]
	
	sub bx,dx
	sbb ax,cx
	
	mov [bp+0x0A],ax
	mov [bp+0x0C],bx	
	
	ret
		
proc_cmp32:
	mov ax,sp
	mov bp,ax		
		
	mov ax,[bp+2]
	cmp word ax,[bp+6]
	jg .above
	jl .below
	je .equal
	.above:
		mov byte [bp+0x0A], 00000001b
		jmp .endcmp
	.below:
		mov byte [bp+0x0A], 10000001b
		jmp .endcmp
	.equal:
		mov ax,[bp+4]
		cmp word ax,[bp+8]
		jg .above
		jl .below
		mov byte [bp+0x0A], 00000000b
	.endcmp:		
	ret

proc_shl32:
	mov ax,sp
	mov bp,ax
	
	xor ax,ax
	mov byte al,[bp+6]
	mov bl,10h
	div bl
					
	cmp al,1
	jb .zero
	je .one	
	jmp .above
	.zero:	
		mov cl,10h
		sub cl,ah
		mov bx,[bp+4]		
		shr bx,cl
		
		mov cl,ah		
		shl word [bp+2],cl
		add word [bp+2],bx				
		shl word [bp+4],cl
		jmp .endzo
	.one:
		mov cl,ah
		mov bx, [bp+4]				
		shl bx, cl 
		mov word [bp+2], bx
		mov word [bp+4], 0
		jmp .endzo
	.above:		
		mov word [bp+2], 0
		mov word [bp+4], 0
	.endzo:	
	
	ret
	
proc_shr32:
	mov ax,sp
	mov bp,ax
	
	xor ax,ax
	mov byte al,[bp+6]
	mov bl,10h
	div bl
					
	cmp al,1
	jb .zero
	je .one	
	jmp .above
	.zero:	
		mov cl,10h
		sub cl,ah		
		mov bx,[bp+2]		
		shl bx,cl
		
		mov cl,ah		
		shr word [bp+2],cl
		shr word [bp+4],cl
		add word [bp+4],bx	
		jmp .endzo
	.one:			
		mov cl,ah
		mov bx,[bp+2]
		shr bx,cl
		mov word [bp+2],0 
		mov word [bp+4],bx
		jmp .endzo
	.above:		
		mov word [bp+2],0
		mov word [bp+4],0
	.endzo:		

	ret
	
proc__lzcount16:
	mov ax,sp
	mov bp,ax
	
	mov cl,0
		
	mov ah, [bp+3]	
	and ah,0xF0
	cmp ah,0
	jnz .end
	inc cl
	
	mov ah, [bp+3]
	and ah,0x0F
	cmp ah,0
	jnz .end
	inc cl
	
	mov ah, [bp+2]
	and ah,0xF0
	cmp ah,0
	jnz .end
	inc cl
	
	mov ah, [bp+2]
	and ah,0x0F
	cmp ah,0
	jnz .end
	inc cl
		
	.end:
	mov byte [bp+4], cl
	
	ret

proc__lzbitcount16:
	mov ax,sp
	mov bp,ax
	
	mov word ax,[bp+2]
		
	mov cl,0
	.l1:
		cmp cl,16
		jae .l2
		
		mov bx,ax
		shl bx,cl
		shr bx,15
		
		cmp bx,0
		jnz .l2
		
		inc cl		
		jmp .l1
	.l2:
	
	mov byte [bp+4], cl
	
	ret
	
proc__lzbitcount8:
	mov ax,sp
	mov bp,ax
	
	mov byte al,[bp+2]
	
	mov cl,0
	.l1:
		cmp cl,8
		je .l2
		
		mov bl,al
		shl bl,cl
		shr bl,7
		
		cmp bl,0
		jnz .l2
		
		inc cl		
		jmp .l1
	.l2:
	
	mov byte [bp+3], cl
		
	ret
	
proc_calc_dividendo1:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+6]
	mov bx,[bp+8]
	push bp
	__lzbitcount32 ax, bx, cl
	pop bp
	mov bl,32
	sub bl,cl
	push bx
		
	mov ax,[bp+2]
	mov dx,[bp+4]
	push bp
	__shr32 ax, dx, cl
	pop bp
	push ax
	push dx	
	
	mov cx,[bp+6]
	mov bx,[bp+8]
	
	push bp
	__cmp32 ax, dx, cx, bx, cl
	pop bp
	pop dx
	pop ax
	pop bx
		
	cmp cl,0
	jge .l1
		stkopen 9
		mov cx,[bp+0x0B]
		mov word [bp+0], cx
		mov cx,[bp+0x0D]
		mov word [bp+2], cx
		mov word [bp+4], ax
		mov word [bp+6], dx
		mov byte [bp+8], bl
		call proc_calc_prox_dividendo
		mov ax,sp
		mov bp,ax
		mov word ax,[bp+4]
		mov word dx,[bp+6]
		mov byte bl,[bp+8] 
		stkclose 9		 
	.l1:
	
	mov cx,sp
	mov bp,cx
	mov word [bp+0x0A], ax
	mov word [bp+0x0C], dx
	mov byte [bp+0x0E], bl	 
	
	ret

proc_calc_prox_dividendo:
	mov ax,sp
	mov bp,ax
	
	xor ah,ah	
	mov al,[bp+0x0A]
	mov bl,10h
	div bl
	
	cmp al,0
	jz .zero
	jmp .one
	.zero:
		mov bx,[bp+2]
		jmp .endcmp
	.one:
		mov bx,[bp+4]		
	.endcmp:
		
	mov cl,ah
	shl bx,cl
	shr bx,15
	
	mov ax,[bp+6]
	mov dx,[bp+8]
	push bx
	__shl32 ax, dx, 1
	pop bx
	
	add dx,bx
	adc ax,0

	mov cx,sp
	mov bp,cx	
	mov [bp+6],ax
	mov [bp+8],dx
	
	inc byte [bp+0x0A]
	
	ret
	
%endif