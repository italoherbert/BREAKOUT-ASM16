%include "lib/crt.csts"

section .data
			
crt_writehex: 
	mov ax,[esp+2]
	push ax	
	
	mov cx,4	
	crt_writehex_loop:				
		mov ax,4
		sub ax,cx								
		
		pop dx	
		push dx
		push cx					
															
		crt_writehex_loop11:
			cmp ax,0
			jbe crt_writehex_endloop11
							
			shl dx,4
			dec ax
			jmp crt_writehex_loop11
		crt_writehex_endloop11:
						
		shr dx,12							
						
		cmp dl,9
		ja crt_writehex_sumseven
		jmp crt_writehex_notsumseven  
		
		crt_writehex_sumseven:
			add dl,7
		crt_writehex_notsumseven:
						
		add dl,30h
		
		push dx
		call crt_write
		pop dx
				
		pop cx
	loop crt_writehex_loop					
	
	pop dx
	
	mov al,68h
	push ax
	call crt_write
	pop ax
		
	ret				

crt_read:
	call crt_readkey
	push ax	

	xor bx,bx
	mov bl,al
	push bx
	call crt_write	
	pop bx

	pop ax

	ret	

crt_readkey:
	mov ah,00h
	int 16h
	ret		

crt_writestr:	
	mov ax,cs
	mov ds,ax

	mov si,[esp+2]

	crt_writestr_printloop:
		lodsb
		cmp al,0h
		jz crt_writestr_printdone

		push ds
		push si
					
		push ax
		call crt_write
		pop ax
		
		pop si
		pop ds
		
		jmp crt_writestr_printloop 
	crt_writestr_printdone:
	ret
	
crt_write:	
	mov ax,cs
	mov ds,ax	
			
	; get cursor
	mov ah,03h
	mov bh,00h
	int 10h
		
	; seta cursor e cores (texto,fundo)	
	mov ax,0600h
	mov cx,dx
	mov bh,[_CRT_TEXTBG]
	mov bl,[_CRT_TEXTCOLOR]
	shl bl,4
	shl bx,4
	int 10h
	
	; imprime caracter
	mov ah,0Eh
	mov bh,00h
	mov al,[esp+2]	
	int 10h				
		
	; INICIO - nova linha se necessário

	; get cursor				
	mov ah,03h
	mov bh,00h
	int 10h				
		
	mov al,[_CRT_X2]
	cmp dl,al	
	ja crt_write_xoutbound
	jmp crt_write_xsetted
	
	crt_write_xoutbound:
		call crt_newline
	crt_write_xsetted:
	
	mov ah,[_CRT_Y2]
	cmp dh,ah	
	ja crt_write_youtbound
	jmp crt_write_ysetted
	
	crt_write_youtbound:
		mov ax,0
		mov bx,0
		push ax
		push bx		
		call crt_gotoxy
		pop bx
		pop ax
	crt_write_ysetted:			

	; FIM - nova linha se necessário
	
	ret
	
crt_yscroll:	
	mov ax,cs
	mov ds,ax		
	
	mov ax,0701h
	mov bh,0	
	mov ch,[_CRT_Y1]
	mov cl,[_CRT_X1]
	mov dh,ch
	mov dl,[_CRT_X2]
	int 10h		
	ret	
	
crt_newline:	
	mov ax,cs
	mov ds,ax	
	
	mov ah,03h	
	int 10h
			
	inc dh
	mov dl,[_CRT_X1]
			
	mov ah,02h
	mov bh,0
	int 10h		
	
	ret

crt_gotoxy:		
	mov ax,cs
	mov ds,ax
	
	mov ah,02h
	mov bh,00h
	mov dh,[esp+2]
	mov dl,[esp+4]
	add dh,[_CRT_Y1]
	add dl,[_CRT_X1]
	int 10h
	ret

crt_inittextmode:	
	mov ax,cs
	mov ds,ax
	mov es,ax	
	
	mov ah,CRT_Y1
	mov al,CRT_X1	
	mov [_CRT_Y1],ah
	mov [_CRT_X1],al

	mov ah,CRT_Y2
	mov al,CRT_X2		
	mov [_CRT_Y2],ah
	mov [_CRT_X2],al

	mov ah,CRT_TEXTBG
	mov al,CRT_TEXTCOLOR	
	mov [_CRT_TEXTBG],ah		
	mov [_CRT_TEXTCOLOR],al
			
	mov ah,00h
	mov al,CRT_MODE
	int 10h		

	call crt_clrscr

	ret
	
crt_textbackground:	
	mov ax,cs
	mov es,ax
					
	mov al,[esp+2]		
	mov [_CRT_TEXTBG],al
	
	ret
		
crt_textcolor:	
	mov ax,cs	
	mov es,ax
	
	mov al,[esp+2]
	mov [_CRT_TEXTCOLOR],al	
		
	ret

crt_window:		
	mov ax,cs
	mov es,ax
			
	mov ax,[esp+4]
	mov [_CRT_Y1],ah
	mov [_CRT_X1],al
	
	mov ax,[esp+2]
	mov [_CRT_Y2],ah
	mov [_CRT_X2],al
				
	ret

crt_clrscr:		
	mov ax,cs
	mov ds,ax
	
	mov ch,[_CRT_Y1]
	mov cl,[_CRT_X1]
	
	mov dh,[_CRT_Y2]
	mov dl,[_CRT_X2]
	
	mov bh,[_CRT_TEXTBG]
	mov bl,[_CRT_TEXTCOLOR]

	shl bl,4
	shl bx,4
			
	mov ax,0600h
	int 10h
	
	; move cursor
	mov ah,02h
	mov bh,00h
	mov dh,[_CRT_Y1]
	mov dl,[_CRT_X1]
	int 10h		

	ret
	