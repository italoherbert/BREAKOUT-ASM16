
;%include "lib/system.mac"
%include "lib/stdio.mac"
		
section .text
	global _start
	
_start:	
	mov ax,1000h
	mov ds,ax
	
	mov ss,ax
	mov sp,0xFFFE
		
	prtstr "stack ---> "
	mov ax,sp
	prthex16 ax
	prtln	 	
	prtln
		
	; LEITURA

		mov ah,02h
		mov dl,80h
				
		; LBA (0, 2, 1) = ( ( ( 0 * 16 ) + 2 ) * 63 ) + 1 - 1 = 2 * 63 + 0 = 126
		; LBA (1, 6, 5) = ( ( ( 1 * 16 ) + 6 ) * 63 ) + 5 - 1 = (22 * 63) + 4 = 1390
		mov ch,0	; cilindro (0 .. 975)
		mov dh,2	; cabeça (0 .. 30)
		mov cl,1	; setor (1 .. 63)
		
		mov al,1
		
		mov bx,3000h
		mov es,bx
		mov bx,0000h
		int 13h
		
		jc error
		jmp nerror
		error:
			prtstr "Erro. COD="
			prthex8 ah
			jmp end
		nerror:
			mov ax,3000h
			mov ds,ax
			mov si,0
			
			prtstr ds, si			
		end:
	
	; LEITURA	
	
	prtln
	prtln
	prtstr "stack ---> "
	mov ax,sp
	prthex16 ax
		
	jmp $		