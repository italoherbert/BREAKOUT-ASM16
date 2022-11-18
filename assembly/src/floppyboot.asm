section .text
	global _start

_start:		
	xor ax,ax
	mov ds,ax
			
	mov ax,0x7FFE
	mov ss,ax

	mov ah,00h
	mov al,03h
	int 10h

	; Carrega kernel na memória
	mov ah,02h						
	mov dl,00h						

	mov dh,0						; Cabeçote
	mov ch,0						; Trilha
	mov cl,2						; Setor	
	mov al,0x11						; Quantidade de setores

	mov bx,0x0050		 
	mov es,bx
	mov bx,0x0000		
	int 13h
	
	mov ah,02h						
	mov dl,00h						

	mov dh,1						; Cabeçote
	mov ch,0						; Trilha
	mov cl,1						; Setor	
	mov al,0x12						; Quantidade de setores

	mov bx,0x0050		 
	mov es,bx
	mov bx,0x2200		
	int 13h	
	
	mov ah,02h						
	mov dl,00h						

	mov dh,0						; Cabeçote
	mov ch,1						; Trilha
	mov cl,1						; Setor	
	mov al,0x12						; Quantidade de setores

	mov bx,0x0050		 
	mov es,bx
	mov bx,0x4600	
	int 13h								

	; Muda execução para o kernel
	jmp 0x0050:0x0000	
	