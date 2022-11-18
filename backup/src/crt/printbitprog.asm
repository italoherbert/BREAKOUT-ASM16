%include "src/crt.asm"

section .text
	global _start

_start:	
	call inittextmode
		
	mov ax,0505h
	mov bx,0F4Ah
	push ax
	push bx
	call window
	pop bx
	pop ax	
			
	call clrscr
	loop1:
		mov cx,0302h	
		loop2:										
			push cx
			
			mov ah,00h
			int 1Ah					
			
			mov ax,dx
			shl al,4
			shr al,4
			xor ah,ah			
			mov bl,2			
			div bl
			
			cmp ah,0
			je loop2_par
			jmp loop2_impar
			loop2_par:
				mov al,30h
				jmp loop2_endparimpar
			loop2_impar:
				mov al,31h
			loop2_endparimpar:
			
			push ax
			call writechar
			pop ax
			
			pop cx
		loop loop2
		
		mov ah,01h
		int 16h
		cmp al,1Bh
		je endloop1
					
		jmp loop1
	endloop1:
	
	jmp $