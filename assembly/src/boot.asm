; ===================================================================
;		Mapeamento de Memoria
; ===================================================================

; 	Espaço de memória livre de 0x0500 até 0xA0000 --> 654080(B)

; -------------------------------------------------------------------
;	638(KB) + 768(B) -->  0x0500   ..   0xA0000			DIF=0x9FB00
; -------------------------------------------------------------------
; 	2(KB) + 768(B)   -->  0x0500   ..   0x0FFF			DIF=0xB00
;   60(KB)	 		 -->  0x1000   ..   0x0FFFF			DIF=0xF000	
;  	9 * 64(KB)	 	 -->  0x10000  ..   0x9FFFF			DIF=0x90000
; -------------------------------------------------------------------

; -------------------------------------------------------------------
;	Mapeamento de memoria padrão para os segmentos
; -------------------------------------------------------------------
; 	KERNEL --> 63KB + 738(B) -->  0x0500   ..   0x1FFFF	DIF=0xFB00
; -------------------------------------------------------------------

;	
; 	8 Segmentos livres de 0x20000 até 0x9FFFF


; Programa carregado a partir do primeiro disco rigido (ou pendrive)
; Programa carregado na memória em (0800:0000)
; O programa deve estar gravado a partir do setor 2 do disco

section .text
	global _start

_start:			
	mov ax,0x7FFE
	mov ss,ax
	
	xor ax,ax
	mov ds,ax	

	mov ah,00h
	mov al,03h
	int 10h
	
	; Carrega kernel na memória
	mov ah,02h						; Função de leitura do disco
	mov dl,80h						; Numero do driver do dispositivo

	mov ch,0						; Trilha
	mov dh,0						; Cabeçote
	mov cl,2						; Setor	
	mov al,54						; Quantidade de setores

	mov bx,0x0050		; Segmento de memoria onde o programa sera carregado 
	mov es,bx
	mov bx,0x0000		; Offset no segmento onde o programa sera carregado
	int 13h							

	; Muda execução para o kernel
	jmp 0x0050:0x0000	
	