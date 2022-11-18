
%ifndef FLOAT_ASM
	%define FLOAT_ASM
	
	%include "lib/system.mac"
	%include "lib/math.mac"
	
%macro __fltoint16 3
	stkopen 0x06
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc_fltoint16
	push sp
	pop bp
	mov word %3,[bp+4]
	stkclose 0x06
%endmacro

%macro __flroundtoint16 3
	stkopen 0x06
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc_flroundtoint16
	push sp
	pop bp
	mov word %3,[bp+4]
	stkclose 0x06
%endmacro

%macro __int16tofl 3	
	stkopen 0x06
	mov word [bp+0],%1
	call proc_int16tofl
	push sp
	pop bp
	mov word %2,[bp+2]
	mov word %3,[bp+4]
	stkclose 0x06
%endmacro
		
%macro __flroundtoint32 4
	stkopen 0x08
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc_flroundtoint32
	push sp
	pop bp
	mov word %3,[bp+4]
	mov word %4,[bp+6]
	stkclose 0x08
%endmacro		
		
%macro __fltoint32 4
	stkopen 0x08
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc_fltoint32
	push sp
	pop bp
	mov word %3,[bp+4]
	mov word %4,[bp+6]
	stkclose 0x08
%endmacro

%macro __int32tofl 4
	stkopen 0x08
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc_int32tofl
	push sp
	pop bp
	mov word %3,[bp+4]
	mov word %4,[bp+6]
	stkclose 0x08
%endmacro

%macro __flcmp 5
	stkopen 0x09
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	call proc_flcmp
	push sp
	pop bp
	mov byte %5, [bp+8]
	stkclose 0x09
%endmacro
	
%macro __flshl 2
	stkopen 0x03
	mov word [bp+0],%1
	mov byte [bp+2],%2
	call proc_flshl
	push sp
	pop bp
	mov word %1,[bp+0]
	stkclose 0x03
%endmacro	

%macro __flshr 2
	stkopen 0x03
	mov word [bp+0],%1
	mov byte [bp+2],%2
	call proc_flshr
	push sp
	pop bp
	mov word %1,[bp+0]
	stkclose 0x03
%endmacro	
	
%macro __flinvsig 1
	stkopen 0x02
	mov word [bp+0],%1
	call proc_flinvsig
	push sp
	pop bp
	mov word %1, [bp+0]
	stkclose 0x02
%endmacro

%macro __flsetsig 1
	stkopen 0x04
	mov word [bp+0],%1
	mov word [bp+2],0x8000
	call proc_flsetsig
	push sp
	pop bp
	mov word %1, [bp+0]
	stkclose 0x04
%endmacro	

%macro __flclearsig 1
	stkopen 0x04
	mov word [bp+0],%1
	mov word [bp+2],0
	call proc_flclrsig
	push sp
	pop bp
	mov word %1, [bp+0]
	stkclose 0x04
%endmacro		
	
%macro __fladd 6
	stkopen 0x0E
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	mov word [bp+0x0C],0
	call proc_fladdorsub
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	stkclose 0x0E
%endmacro

%macro __flsub 6
	stkopen 0x0E
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	mov word [bp+0x0C],0x8000
	call proc_fladdorsub
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	stkclose 0x0E
%endmacro

%macro __flmul 6
	stkopen 0x0E
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	call proc_flmul
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	stkclose 0x0E
%endmacro

%macro __fldiv 6
	stkopen 0x0E
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	call proc_fldiv
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	stkclose 0x0E
%endmacro

%macro __validate 7
	stkopen 0x0D
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	call proc__validate
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	mov byte %7,[bp+0x0C]
	stkclose 0x0D
%endmacro

%macro __div_validate 7
	stkopen 0x0D
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	call proc__div_validate
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	mov byte %7,[bp+0x0C]
	stkclose 0x0D
%endmacro

%macro __mul_validate 5
	stkopen 0x09
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc__mul_validate
	push sp
	pop bp
	mov word %3,[bp+4]
	mov word %4,[bp+6]
	mov byte %5,[bp+8]
	stkclose 0x09
%endmacro

%macro __addorsub_validate 7
	stkopen 0x0D
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	call proc__addorsub_validate
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	mov byte %7,[bp+0x0C]
	stkclose 0x0D
%endmacro

%macro __cmp_validate 4
	stkopen 0x06
	mov word [bp+0],%1
	mov word [bp+2],%2
	call proc__cmp_validate
	push sp
	pop bp
	mov byte %3, [bp+4]
	mov byte %4, [bp+5]
	stkclose 0x06
%endmacro

%macro __iaddorsub32 7
	stkopen 0x0D
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	mov word [bp+0x0C], %7
	call proc__iaddorsub32
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	stkclose 0x0D
%endmacro

%macro __fldiv32 6
	stkopen 0x11
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	call proc__fldiv32
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	stkclose 0x11
%endmacro

%macro __mul32_64 8
	stkopen 0x10
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	mov word [bp+6],%4
	call proc__mul32_64
	push sp
	pop bp
	mov word %5,[bp+8]
	mov word %6,[bp+0x0A]
	mov word %7,[bp+0x0C]
	mov word %8,[bp+0x0E]
	stkclose 0x10
%endmacro

%macro __normalize 3
	stkopen 0x06
	mov word [bp+0],%1
	mov word [bp+2],%2
	mov word [bp+4],%3
	call proc__normalize
	push sp
	pop bp
	mov word %1,[bp+0]
	mov word %2,[bp+2]
	stkclose 0x06
%endmacro

section .data

proc_fltoint16:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	__fltoint32 ax, bx, ax, bx
	__int32to16 ax, bx, cx
	
	mov ax,sp
	mov bp,ax
	mov [bp+6],cx
	
	ret
	
proc_flroundtoint16:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	__flroundtoint32 ax, bx, ax, bx
	__int32to16 ax, bx, cx
	
	mov ax,sp
	mov bp,ax
	mov [bp+6],cx
	
	ret
	
proc_int16tofl:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	__int16to32 ax, ax, bx
	__int32tofl ax, bx, cx, dx
	
	mov ax,sp
	mov bp,ax
	mov [bp+4],cx
	mov [bp+6],dx

	ret

proc_flroundtoint32:
	mov ax,sp
	mov bp,ax

	mov ax,[bp+2]
	mov bx,[bp+4]
		
	and ax,0x7FFF	
	or ax,bx
	cmp ax,0
	jnz .continue
	.zero:
		mov word [bp+6],0
		mov word [bp+8],0
		jmp .done
	.one:
		mov ax,[bp+2]
		and ax,0x8000
		cmp ax,0
		jnz .oneneg
			mov word [bp+6], 0
			mov word [bp+8], 1
			jmp .done
		.oneneg:
			mov word [bp+6], 0xFFFF
			mov word [bp+8], 0xFFFF					
			jmp .done
	.continue:
	
	mov cx,[bp+2]
	shl cx,1
	sub ch,0x7F
	cmp ch,0xFF
	jl .zero
	je .one	
		
	mov cl,23	
	cmp ch,cl
	jae .endexp
		sub cl,ch
	.endexp:
	
	mov ax,[bp+2]
	and ax,0x007F
	or ax,0x0080
	
	mov bx,[bp+4]		
	
	dec cl
	push bp	
	__shr32 ax, bx, cl
	pop bp
	push bx
	push bp
	__shr32 ax, bx, 1
	pop bp			
	
	pop dx
	and dx,0x0001
	cmp dx,0
	jz .rounded
		inc bx
		adc ax,0
	.rounded:
				
	mov cx,[bp+2]
	and cx,0x8000
	cmp cx,0
	jz .endneg			
		mov cx,0xFFFF
		mov dx,0xFFFF
		sub dx,bx
		sbb cx,ax						
		inc dx
		adc cx,0
		mov ax,cx
		mov bx,dx		
	.endneg:			
		 
	mov [bp+6],ax
	mov [bp+8],bx
	
	.done:
	
	ret
	
proc_fltoint32:
	mov ax,sp
	mov bp,ax

	mov ax,[bp+2]
	mov bx,[bp+4]
		
	and ax,0x7FFF	
	or ax,bx
	cmp ax,0
	jnz .continue
	.zero:
		mov word [bp+6],0
		mov word [bp+8],0
		jmp .done
	.continue:
	
	mov cx,[bp+2]
	shl cx,1
	sub ch,0x7F
	cmp ch,0
	jl .zero
		
	mov cl,23	
	cmp ch,cl
	jae .endexp
		sub cl,ch
	.endexp:
	
	mov ax,[bp+2]
	and ax,0x007F
	or ax,0x0080
	
	mov bx,[bp+4]		
	
	push bp	
	__shr32 ax, bx, cl
	pop bp		
					
	mov cx,[bp+2]
	and cx,0x8000
	cmp cx,0
	jz .endneg			
		mov cx,0xFFFF
		mov dx,0xFFFF
		sub dx,bx
		sbb cx,ax						
		inc dx
		adc cx,0
		mov ax,cx
		mov bx,dx		
	.endneg:			
		 
	mov [bp+6],ax
	mov [bp+8],bx
	
	.done:
	
	ret
			
proc_int32tofl:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	
	mov cx,ax
	and cx,0x7FFF
	or cx,bx
	cmp cx,0
	jnz .continue
		mov ax,[bp+2]
		and ax,0x8000
		mov word [bp+6],ax
		mov word [bp+8],0
		jmp .done
	.continue:
		
	mov cx,ax
	and cx,0x8000
	cmp cx,0
	jz .endneg
		mov cx,0xFFFF
		mov dx,0xFFFF
		sub dx,bx
		sbb cx,ax
		inc dx
		adc cx,0
		mov ax,cx
		mov bx,dx
	.endneg:
	
	and ax,0x007F	
	
	mov [bp+6],ax
	mov [bp+8],bx	
		
	__lzbitcount32 ax, bx, ch		
	mov cl,32
	sub cl,ch
	
	cmp cl,24
	jae .endmantissa
	
	mov dl,24
	sub dl,cl				
	
	mov ax,sp
	mov bp,ax
	mov ax,[bp+6]
	mov bx,[bp+8]
	
	push cx	
	__shl32 ax, bx, dl	
	pop cx
	
	.endmantissa:
	
	and ax,0x007F
		
	add cl,0x7E
	shl cx,8
	shr cx,1
	add ax,cx
	
	mov cx,sp
	mov bp,cx
	
	mov cx,[bp+2]
	and cx,0x8000	
	add ax,cx
		
	mov [bp+6],ax
	mov [bp+8],bx
	
	.done:		
	
	ret
	
proc_flcmp:
	mov ax,sp
	mov bp,ax		
	
	mov ax,[bp+2]
	mov bx,[bp+6]
	push bp
	__cmp_validate ax, bx, cl, dl
	pop bp
	cmp dl,0
	jnz .continue
		mov byte [bp+0x0A], cl
		jmp .done		
	.continue:
			
	mov ax,[bp+2]
	mov bx,[bp+6]
	and ax,0x8000
	and bx,0x8000	
	cmp ax,bx
	jb .above
	ja .below
	
	mov ax,[bp+2]
	mov bx,[bp+6]
	shl ax,1
	shl bx,1
	cmp ah,bh
	ja .above
	jb .below
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov dx,[bp+8]
	
	__cmp32 ax, bx, cx, dx, cl
	jmp .endcmp
		
	.above:
		mov cl, 1
		jmp .endcmp
	.below:
		mov cl, -1
		jmp .endcmp
	.equal:	
		mov cl, 0	
	.endcmp:
	
	mov ax,sp
	mov bp,ax
	mov byte [bp+0x0A], cl
	
	.done:
					
	ret

proc_flshl:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	and ax,0x7F80
	shl ax,1
	add ah, [bp+4]	
	shr ax,1
	
	mov bx,[bp+2]
	and bx,0x807F
	add bx,ax
	
	mov [bp+2],bx		
	
	ret

proc_flshr:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	and ax,0x7F80
	shl ax,1
	sub ah, [bp+4]	
	shr ax,1
	
	mov bx,[bp+2]
	and bx,0x807F
	add bx,ax
	
	mov [bp+2],bx	
	
	ret

proc_fldiv:
	mov ax,sp
	mov bp,ax
				
	; sinal
	
	mov ax,[bp+2]
	mov bx,[bp+6]
	and ax,0x8000
	and bx,0x8000
	xor ax,bx
	mov word [bp+0x0A],ax
		
	; sinal calculado e setado

	; valores especiais
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov dx,[bp+8]
	__validate ax, bx, cx, dx, ax, bx, cl
	cmp cl,0
	jnz .continue
		mov dx,sp
		mov bp,dx
		add word [bp+0x0A],ax
		mov word [bp+0x0C],bx						
		jmp .done	
	.continue:
	
	mov ax,sp
	mov bp,ax
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov dx,[bp+8]
	__div_validate ax, bx, cx, dx, ax, bx, cl
	cmp cl,0
	jnz .continue2
		mov dx,sp
		mov bp,dx
		add word [bp+0x0A],ax
		mov word [bp+0x0C],bx				
		jmp .done	
	.continue2:
	; valores especiais tratados
			
	; expoente parcial

	mov ax,sp
	mov bp,ax
	mov ax,[bp+2]
	mov bx,[bp+6]
	and ax,0x7F80
	and bx,0x7F80
	shl ax,1
	shl bx,1		
			
	sub ah,bh		
	add ah,0x7F
	
	push ax
		
	; expoente parcial calculado
	
	; mantissa

	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov dx,[bp+8]
	and ax,0x007F
	and cx,0x007F
	or ax,0x0080
	or cx,0x0080
	
	__fldiv32 ax, bx, cx, dx, cx, dx
		
	mov ax,sp
	mov bp,ax
	add bp,2
	
	add cx,[bp+0x0A]
			
	pop ax	
	__normalize cx, dx, ax
	
	mov ax,sp
	mov bp,ax
	mov [bp+0x0A],cx
	mov [bp+0x0C],dx
	
	.done:
			
	ret

proc_flmul:
	mov ax,sp
	mov bp,ax
	
	; sinal
	
	mov ax,[bp+2]
	mov bx,[bp+6]
	and ax,0x8000
	and bx,0x8000
	xor ax,bx
	mov word [bp+0x0A],ax
	
	; sinal calculado e setado

	; valores especiais

	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov dx,[bp+8]
	__validate ax, bx, cx, dx, ax, bx, cl
	cmp cl,0
	jnz .continue
		mov dx,sp
		mov bp,dx
		add word [bp+0x0A],ax
		mov word [bp+0x0C],bx						
		jmp .done	
	.continue:

	mov ax,sp
	mov bp,ax
	mov ax,[bp+2]
	mov cx,[bp+6]
	__mul_validate ax, cx, ax, bx, cl
	cmp cl,0
	jnz .continue2
		mov dx,sp
		mov bp,dx
		add word [bp+0x0A],ax
		mov word [bp+0x0C],bx				
		jmp .done	
	.continue2:
	; valores especiais tratados
		
	; expoente parcial

	mov ax,sp
	mov bp,ax
	mov ax,[bp+2]
	mov bx,[bp+6]
	and ax,0x7F80
	and bx,0x7F80
	shl ax,1
	shl bx,1		
			
	sub ah,0x7F
	sub bh,0x7F
				
	add ah,bh
	add ah,0x7F
	
	push ax
	
	; expoente parcial calculado	
	
	; mantissa
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov dx,[bp+8]	
	
	and ax, 0x007F
	and cx, 0x007F
	or ax, 0x0080
	or cx, 0x0080
		
	__mul32_64 ax, bx, cx, dx, ax, bx, cx, dx
	
	push cx
	__shl32 ax, bx, 8
	pop cx
	mov bl,ch
								
	push ax
	push bx
	__lzbitcount32 ax, bx, cl
	pop bx
	pop ax
		
	sub cl,8	
	cmp cl,8
	je .equal
	jg .great
	.equal:	
		pop dx
		inc dh
		push dx
		jmp .endcmp
	.great:
		__shl32 ax, bx, cl
	.endcmp:
	
	mov cx,sp
	mov bp,cx
	add bp,2
	
	add word [bp+0x0A],ax
	mov word [bp+0x0C],bx
	
	; mantissa setada e expoente calculado
				
	mov cx,[bp+0x0A]
	mov dx,[bp+0x0C]
	
	pop ax						
	__normalize cx, dx, ax	; normaliza, preserva sinal e seta expoente	
		
	mov ax,sp
	mov bp,ax
	mov [bp+0x0A],cx
	mov [bp+0x0C],dx		

	.done:
																	
	ret
	
proc_fladdorsub:	
	; valores especiais
	mov ax,sp
	mov bp,ax
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	and cx,0x8000
	xor word cx,[bp+0x0E]	
	mov dx,[bp+6]
	and dx,0x7FFF
	add cx,dx	
	mov dx,[bp+8]
	__validate ax, bx, cx, dx, ax, bx, cl
	cmp cl,0
	jnz .continue
		mov dx,sp
		mov bp,dx		
		mov word [bp+0x0A],ax
		mov word [bp+0x0C],bx										
		jmp .done	
	.continue:
	
	mov ax,sp
	mov bp,ax
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	and cx,0x8000
	xor word cx,[bp+0x0E]	
	mov dx,[bp+6]
	and dx,0x7FFF
	add cx,dx
	mov dx,[bp+8]
	__addorsub_validate ax, bx, cx, dx, ax, bx, cl
	cmp cl,0
	jnz .continue2
		mov dx,sp
		mov bp,dx					
		mov word [bp+0x0A],ax
		mov word [bp+0x0C],bx
		jmp .done	
	.continue2:
	
	; valores especiais tratados	

	mov ax,sp
	mov bp,ax	
	mov ax,[bp+2]
	mov bx,[bp+6]
	
	shl ax,1
	shl bx,1
	mov ch,ah	
	sub ch,bh	
		
	cmp ch,0
	jz .expzero
	jmp .expnzero
	.expzero:
		push ax
		mov ax,[bp+2]
		mov bx,[bp+4]
		mov cx,[bp+6]
		mov dx,[bp+8]
		and ax,0x807F
		and cx,0x807F
		or ax,0x0080
		or cx,0x0080
												
		jmp .endexpcmp
	.expnzero:
				
		cmp ch,0
		jg .exp1great
		jl .exp1less
		jmp .endexpcmp
		.exp1great:					
			push ax
		
			mov ax,[bp+6]
			mov bx,[bp+8]
			and ax,0x007F
			or ax,0x0080
						
			push bp
			__shr32 ax, bx, ch
			pop bp		
				
			mov dx,[bp+6]
			and dx,0x8000
			add ax,dx			
			
			mov cx,ax
			mov dx,bx
			mov ax,[bp+2]
			mov bx,[bp+4]										
									
			and ax,0x807F
			or ax,0x0080
						
			jmp .endexp1cmp	
		.exp1less:
			mov cl,ch
			mov ch,0xFF
			sub ch,cl
			inc ch
			push bx		
		
			mov ax,[bp+2]
			mov bx,[bp+4]
			and ax,0x007F
			or ax,0x0080
						
			push bp
			__shr32 ax, bx, ch
			pop bp
								
			mov dx,[bp+2]
			and dx,0x8000
			add ax,dx			
			
			mov cx,[bp+6]
			mov dx,[bp+8]										
									
			and cx,0x807F
			or cx,0x0080
									
		.endexp1cmp:
		
	.endexpcmp:			
	
	cmp word [bp+0x0E],0
	jnz .sub
		__iaddorsub32 ax, bx, cx, dx, ax, bx, 0
		jmp .endop
	.sub:
		__iaddorsub32 ax, bx, cx, dx, ax, bx, 0x8000
	.endop:
						
	pop cx
	
	__normalize ax, bx, cx
	
	mov cx,sp
	mov bp,cx
	mov word [bp+0x0A],ax
	mov word [bp+0x0C],bx
									
	.done:		
							
	ret
	
proc__normalize:
	mov ax,sp
	mov bp,ax	

	mov cx,[bp+2]	
	mov dx,[bp+4]
	mov bx,[bp+6]
					
	mov ax,cx
	and ax,0x8000			
	mov [bp+2],ax	
					
	and cx,0x7FFF
			
	push cx
	push dx
	push bx
	__lzbitcount32 cx, dx, al	
	pop bx
	pop dx
	pop cx								
		
	cmp al,8					
	jb .shr
	ja .shl
	jmp .endshrl
	.shr:			
		mov ah,0x08
		sub ah,al
		add bh,ah
		push bx
		__shr32 cx, dx, ah
		pop bx
		jmp .endshrl
	.shl:		
		mov ah,0x08
		sub al,ah
		sub bh,al			
		push bx
		__shl32 cx, dx, al
		pop bx			
	.endshrl:											
								
	xor bl,bl
	shr bx,1	
	and cx,0x007F	
		
	mov ax,sp
	mov bp,ax
	add word [bp+2],bx
	add word [bp+2],cx	
	mov word [bp+4],dx
	
	ret

proc__iaddorsub32:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov dx,[bp+8]	
	
	push ax	
	and ax, 0x8000
	cmp ax,0
	jz .endv1neg
		pop ax
		push cx
		push dx
		
		mov cx,0xFFFF
		mov dx,0xFFFF
		and ax,0x7FFF
		sub dx,bx
		sbb cx,ax
		inc dx
		adc cx,0
		mov ax,cx
		mov bx,dx
		
		pop dx
		pop cx
		push ax	
	.endv1neg:		
	pop ax	
		
	push cx
	and cx,0x8000
	cmp cx,0
	jz .endv2neg
		pop cx
		push ax
		push bx
		
		mov ax,0xFFFF
		mov bx,0xFFFF
		and cx,0x7FFF
		sub bx,dx
		sbb ax,cx
		inc bx
		adc ax,0
		mov cx,ax
		mov dx,bx
		
		pop bx
		pop ax
		push cx
	.endv2neg:	
	pop cx
					
	cmp word [bp+0x0E],0
	jnz .sub
		add bx, dx
		adc ax, cx				
		jmp .endop
	.sub:
		sub bx, dx
		sbb ax, cx
	.endop:
	
	mov cx,ax
	and cx,0x8000
	cmp cx,0
	jz .endresneg
		mov cx,0xFFFF
		mov dx,0xFFFF
		sub dx,bx
		sbb cx,ax
		inc dx
		adc cx,0
		mov ax,cx
		mov bx,dx
		
		add ax,0x8000
	.endresneg:
	
	mov cx,sp
	mov bp,cx
	mov [bp+0x0A], ax
	mov [bp+0x0C], bx
	
	ret	
	
proc__mul32_64:
	mov ax,sp
	mov bp,ax
		
	xor dx,dx
	mov ax,[bp+4]
	mul word [bp+8]
	
	mov word [bp+0x0A], 0
	mov word [bp+0x0C], 0
	mov word [bp+0x0E], dx
	mov word [bp+0x10], ax
		
	xor dx,dx
	mov ax,[bp+4]
	mul word [bp+6]
	
	add [bp+0x0E],ax
	adc [bp+0x0C],dx
	adc word [bp+0x0A],0
	
	xor dx,dx
	mov ax,[bp+2]
	mul word [bp+8]
	
	add [bp+0x0E],ax
	adc [bp+0x0C],dx
	
	xor dx,dx
	mov ax,[bp+2]
	mul word [bp+6]
	
	add [bp+0x0C],ax
	adc [bp+0x0A],dx
	
	ret
	
proc__fldiv32:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	mov word [bp+0x0A],0
	mov word [bp+0x0C],0
	
	mov cl,24
	.l1:
		cmp cl,0
		jz .l2
		push cx
		
		mov cx,[bp+0x0A]
		mov dx,[bp+0x0C]
		push bp
		push ax
		push bx
		__shl32 cx, dx, 1
		pop bx
		pop ax
		pop bp
		mov [bp+0x0A],cx
		mov [bp+0x0C],dx
				
		mov cx,[bp+6]
		mov dx,[bp+8]
		push ax
		push bx
		push bp
		__cmp32 ax, bx, cx, dx, dl
		pop bp
		pop bx
		pop ax				
		
		cmp dl,0
		jl .endsub
			mov cx,[bp+6]
			mov dx,[bp+8]
			push bp									
			__sub32 ax, bx, cx, dx, ax, bx						
			pop bp			
			inc word [bp+0x0C]			
		.endsub:
				
		push bp
		__shl32 ax, bx, 1
		pop bp
		
		pop cx
		dec cl
		jmp .l1
	.l2:
	
	ret

proc_flgetsig:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	and ax,0x8000
	mov [bp+4],ax	
	
	ret

proc_flinvsig:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]	
	mov cx,ax	
	or cx, 0x0000
	not cx
	and cx,0x8000								
	and ax,0x7FFF			
	add ax,cx	
	mov word [bp+2],ax
	
	ret

proc_flsetsig:
	mov ax,sp
	mov bp,ax

	mov ax,[bp+2]
	and ax,0x7FFF
	add ax,[bp+4]
	mov [bp+2],ax
				
	ret

proc__validate:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	and ax,0x7FFF
	cmp ax,0x7FFF
	jne .isnumber1

	mov ax,[bp+4]
	cmp ax,0xFFFF
	jnz .isnumber1
	
	jmp .NaN
	
	.isnumber1:
	
	mov ax,[bp+6]
	and ax,0x7FFF
	cmp ax,0x7FFF
	jne .isnumber2

	mov ax,[bp+8]
	cmp ax,0xFFFF
	jnz .isnumber2
	
	jmp .NaN
	
	.isnumber2:
	
	mov ax,[bp+2]
	shl ax,1
	cmp ah,0xFF
	je .infinity

	mov bx,[bp+6]
	shl bx,1
	cmp bh,0xFF
	je .infinity			
	
	jmp .ok	
	
	.infinity:		
		mov word [bp+0x0A],0x7F80
		mov word [bp+0x0C],0
		jmp .done
	.NaN:
		mov word [bp+0x0A],0x7FFF
		mov word [bp+0x0C],0xFFFF
		jmp .done
			
	.ok:
		mov byte [bp+0x0E],1
		jmp .end
	.done:
		mov byte [bp+0x0E],0		
	.end:
	
	ret

proc__div_validate:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+6]
	shl ax,1
	shl bx,1
	or ah,bh
	cmp ah,0
	jz .NaN
	
	mov ax,[bp+2]
	shl ax,1
	cmp ah,0
	jz .zero
	mov bx,[bp+6]
	shl bx,1
	cmp bh,0	
	jz .infinity		
		
	jmp .ok
	
	.infinity:		
		mov word [bp+0x0A],0x7F80
		mov word [bp+0x0C],0
		jmp .done
	.NaN:
		mov word [bp+0x0A],0x7FFF
		mov word [bp+0x0C],0xFFFF
		jmp .done
	.zero:
		mov word [bp+0x0A],0
		mov word [bp+0x0C],0
		jmp .done	
			
	.ok:
		mov byte [bp+0x0E],1
		jmp .end
	.done:	
		mov byte [bp+0x0E],0
	.end:	
		
	ret
	
proc__mul_validate:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	shl ax,1	
	cmp ah,0	
	jz .zero		

	mov bx,[bp+4]
	shl bx,1
	cmp bh,0
	jz .zero
			
	jmp .ok
	
	.zero:		
		mov word [bp+6],0
		mov word [bp+8],0
		jmp .done
			
	.ok:
		mov byte [bp+0x0A],1
		jmp .end
	.done:	
		mov byte [bp+0x0A],0
	.end:	
		
	ret
	
proc__addorsub_validate:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+6]	
	shl ax,1
	shl bx,1
	or ah,bh
	cmp ah,0
	jz .zero
	
	mov ax,[bp+2]
	shl ax,1
	cmp ah,0		
	jz .value2
	
	mov ax,[bp+6]
	shl ax,1
	cmp ah,0
	jz .value1	
		
	jmp .ok
	
	.zero:		
		mov word [bp+0x0A],0
		mov word [bp+0x0C],0
		jmp .done
	.value1:
		mov ax,[bp+2]
		mov bx,[bp+4]
		mov word [bp+0x0A],ax
		mov word [bp+0x0C],bx		
		jmp .done
	.value2:		
		mov ax,[bp+6]
		mov bx,[bp+8]
		mov word [bp+0x0A],ax
		mov word [bp+0x0C],bx
		jmp .done
			
	.ok:
		mov byte [bp+0x0E],1
		jmp .end
	.done:	
		mov byte [bp+0x0E],0
	.end:	
		
	ret
	

proc__cmp_validate:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+2]
	mov bx,[bp+4]
	shl ax,1
	shl bx,1
	
	mov ch,ah
	xor ch,bh
	cmp ch,0
	jz .ok
		
	cmp ah,0
	jz .zerov1
	
	cmp bh,0
	jz .zerov2	
			
	jmp .ok
	
	.zerov1:
		mov ax,[bp+4]
		and ax,0x8000
		cmp ax,0
		jnz .neg1
			mov byte [bp+6],-1
			jmp .endcmp1
		.neg1:
			mov byte [bp+6], 1
		.endcmp1:
		jmp .done
	.zerov2:		
		mov ax,[bp+2]
		and ax,0x8000
		cmp ax,0
		jnz .neg2
			mov byte [bp+6], 1
			jmp .endcmp2
		.neg2:
			mov byte [bp+6],-1
		.endcmp2:
		jmp .done	
			
	.ok:
		mov byte [bp+7],1
		jmp .end
	.done:	
		mov byte [bp+7],0
	.end:	
		
	ret
	
%endif
