[map all map/kernel/kernel.map]

%include "lib/basic.mac"

section .text
	global _start
	
_start:			
	;showdiskparams		
	;prtln
	;prtln	
	prtstr "Carregando programa em memoria..."
	prtln	
				
	; Carrega programa na memória
	mov ah,02h						; Função de leitura do disco
	mov dl,80h						; Numero do driver do dispositivo

	mov ch,0						; Cilindro
	mov dh,1						; Cabeça
	mov cl,1						; Setor	
	mov al,31						; Quantidade de setores

	mov bx,0x1000					; Segmento de memoria onde o programa sera carregado 
	mov es,bx
	mov bx,0x0000					; Offset no segmento onde o programa sera carregado
	int 13h
		
	jc error			
		mov ax,1000h
		mov ds,ax
		
		mov ss,ax
		mov sp,0xFFFE	
		prtstr "Programa carregado."
		prtln
		prtln
		jmp 0x1000:0x0000	
	error:
		
	push ax	
	prtstr "Houve um erro. COD="
	
	pop ax
	prthex8 ah	
		 
	jmp $			