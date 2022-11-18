%ifndef SYSTEM_ASM
	%define SYSTEM_ASM
			
	%ifndef TRUE
		%define TRUE 01h
	%endif
	%ifndef FALSE
		%define FALSE 00h
	%endif 

section .data		 

; mformat ( startender, endender )
;	lstartender - Parte baixa do endereço físico de início da memória formatada
;	hstartender - Parte alta do endereço físico de início da memória formatada
;	lendender - Parte baixa do endereço físico de termino da memória formatada
;	hendender - Parte alta do endereço físico de termino da memória formatada
mformat:
	mov ax,sp
	mov bp,ax

	mov word dx, [bp+6]
	mov word ax, [bp+4]	
	mov bx, 10h
	div bx
	
	mov ds, ax
	mov si, dx
	
	mov word dx, [bp+6]	
	mov word ax, [bp+4]
	
	add ax, 0x08
	adc dx, 0		
			
	mov word [ si + 0 ], ax	
	mov word [ si + 2 ], dx
	
	mov word dx, [bp+0x0A]
	mov word ax, [bp+8]
	
	mov word [ si + 4 ], ax
	mov word [ si + 6 ], dx
		
	retf


; malloc ( pointer(2W), areapointer(2W), size(1w), error(1B) )
;	spointer(1W) - Onde será armazenado o Segmento do apontador da memória alocada
;	opointer(1W) - Onde será armazenado o Offset do apontador de memória alocada
;	lareapointer(1W) - Palavra baixa do apontador para a área de memória formatada (Endereço físico)
;	hareapointer(1W) - Palavra alta do apontador para a área de memória formatada (Endereço físico)
;	size(1W) - Quantidade de memória a ser alocada
;	error(1B) - Onde será armazenado um código de erro caso haja algum 
;		durante o processo de alocação.
;				Tipos de código: 
;					0 --> Sucesso na operação de alocação de memória
;					1 --> Quantidade de memória livre insuficiente para alocação    
malloc:
	mov ax,sp
	mov bp,ax
			
	mov word dx, [ bp + 0x0A ]
	mov word ax, [ bp + 0x08 ]		
	mov bx,10h
	div bx
			
	mov ds, ax
	mov si, dx
		
	mov word dx, [ si + 2 ]
	mov word ax, [ si + 0 ]	
	cmp word dx, [ si + 6 ]
	ja .error
	jb .alloc		
	cmp word ax, [ si + 4 ]
	jae .error		
		
	.alloc:
				
	mov word cx, [ bp + 0x0C ]
		
	mov word dx, [ si + 2 ]
	mov word ax, [ si + 0 ]
	mov bx,10h
	div bx
		
	mov bx,cx
	add bx,dx
	jnc .abovethrowed
		inc ax
		mov dx, 0x0000						
	.abovethrowed:

	mov word [ bp + 4 ], ax
	mov word [ bp + 6 ], dx

	mov bh,ah
	shr bh,4
	
	shl ax,4
	xor dh,dh
	mov dl,bh
	
	add word ax, [ bp + 6 ]
	adc dx,0

	add ax,cx
	adc dx,0
	
	mov word [ si + 2 ], dx
	mov word [ si + 0 ], ax
	 		
	cmp word dx, [ si + 6 ]
	ja .error
	jb .nerror		
	cmp word ax, [ si + 4 ]
	ja .error
	jmp .nerror	
	.error:
		mov byte [ bp + 0x0E ], 1		
		jmp .enderror
	.nerror:		
		mov byte [ bp + 0x0E ], 0
	.enderror:
			
	retf



; laddr ( logicpointer, fhisicalpointer )
;	slpointer - Onde deve ser armazenado o segmento correspondente ao endereço físico
;	olpointer - Onde deve ser armazenado o offset correspondente ao endereço físico
;	lfpointer - Parte baixa do endereço físico a ser representado como lógico
;	hfpointer - Parte alta do endereço físico a ser representado como lógico
laddr:
	mov ax,sp
	mov bp,ax

	mov word dx, [bp+0x0A]
	mov word ax, [bp+0x08]	
	mov bx, 10h
	div bx
	
	mov word [bp+4], ax
	mov word [bp+6], dx
	
	retf	

; faddr ( fhisicalpointer, logicpointer )
;	lfpointer - Onde deve ser armazenada a parte baixa do endereço físico
;	hfpointer - Onde deve ser armazenada a parte alta do endereço físico	
;	slpointer - Segmento do endereço lógico a ser representado como endereço físico
;	olpointer - Offset do endereço lógico a ser representado como endereço físico
faddr:
	mov ax,sp
	mov bp,ax

	mov word ax, [bp+0x08]
	
	mov bh,ah
	shr bh,4
	
	shl ax,4
	xor dh,dh	
	mov dl,bh
	
	add word ax, [bp+0x0A]
	adc dx, 0
	
	mov word [bp+4], ax
	mov word [bp+6], dx
	
	retf


%endif