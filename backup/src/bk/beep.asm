
%include "lib/stdio.mac"
%include "lib/integer.mac"

; 8255

section .bss
	n: resw 1

section .text
	global _start
	
_start:	

	; Turn on programmable peripherical interface chip (PPI chip) addressed to port 8255
	; Envia sinal de ligar auto-falante (Speaker)
	in al, 61h
	or al, 00000011b
	out 61h, al
	
	
	mov al, 10110110b						
	out 43h, al		
									
	xor ch,ch				
	mov cl,1		
	l1.1:
		cmp cl,7
		ja l1.2	
		push cx
						
		; tocar							
		
		; Frequencia do audio em Hz
		xor dx,dx
		mov ax, 100h	; 128 Hz
		mul cx
		mov bx, ax

		; 1193180 / 512		
		mov dx, 0012h
		mov ax, 34DCh
		div bx
		mov dx,ax
				
		mov al, dl
		out 42h, al		; Least Significant Byte (LSB)
		mov al, dh		
		out 42h, al		; Much Significant Byte (MSB)
						
		; tocar		

		; wait and print
		pusha
		printf "Nota ("
		mov byte [n], cl
		printhex n, 1
		printf ") "
		popa

		mov cl,0
		l1.1.1:
			cmp cl,1
			jae l1.1.2	
			push cx		
												
			mov ah,0Eh
			mov al, '.'
			mov bx,0
			int 10h
			
			mov ah,0Eh
			mov al, 20h
			mov bx,0
			int 10h
			
			mov ah,86h
			mov cx,0010h
			mov dx,0000
			int 15h				
			
			pop cx
			inc cl
			jmp l1.1.1
		l1.1.2:
		pusha
		newline
		popa		
		; end wait and print																					
					
		pop cx
		inc cl
		jmp l1.1
	l1.2:		
		
	; Turn OFF programmable peripherical interface chip (PPI chip)
	; Envia sinal de desligar auto-falante
	in al, 61h
	and al, 11111100b				
	out 61h, al						
						
	newline	
	printf "Qualquer tecla para tocar novamente ou ESQ para sair..."
	newline
	newline
	
	mov ah,00h
	int 16h
	
	cmp al, 1Bh
	jne _start
	
	int 19h

	jmp $
	