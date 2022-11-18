
%include "lib/stdio.mac"
%include "lib/math.mac"

section .data
	auxw: dw 0
	aux: dd 0
	fh: dd 3600
	fm: dd 60		
	seconds: dd 0
	h: db 0
	m: db 0
	s: db 0

	ticks: dd 0
	freq: dd 0

section .text
	global _start
	
_start:
	mov ax,cs
	mov ds,ax

	mov ah,00h
	int 1Ah
	jc fail
	
	cmp al,0
	jz scok
	jmp overflow		
						
	scok:		
		mov word [ticks+2],cx
		mov word [ticks],dx
				
		prtln
		prtln
		prtln
		printf "Numero de tics desde as 0:00 horas: "
			
		prthex32 ticks
		prtln
		prtln
		
		mov ah,02h
		int 1Ah
		jc rtcinprogress
		
		mov [h], ch
		mov [m], cl
		mov [s], dh 
		
		printf "Hora atual: "
		
		mov al,[h]
		prthex8 al
		prtch ':'
		mov al,[m]		
		prthex8 al
		prtch ':'
		mov al,[s]		
		prthex8 al
		prtln
		prtln
		
		printf "Segundos desde as 0:00 horas: "
						
		mov al,[h]
		shr al,4
		mov bl,0x0A
		mul bl
		and byte [h],0x0F
		add [h],al
		
		mov al,[m]
		shr al,4
		mov bl,0x0A
		mul bl
		and byte [m],0x0F
		add [m],al
				
		mov al,[s]
		shr al,4
		mov bl,0x0A
		mul bl
		and byte [s],0x0F
		add [s],al
					
		mov al, [h]				
		mov [aux], al 		
		mul32 aux, fh, aux
		add32 seconds, aux, seconds
			
		mov dword [aux],0
		mov al, [m]				
		mov [aux], al 
		mul32 aux, fm, aux		
		add32 seconds, aux, seconds
		
		
		mov dword [aux],0
		mov al, [s]				
		mov [aux], al
		add32 seconds, aux, seconds
		
		div32 ticks, seconds, freq, aux, auxw		
		
		prthex32 seconds
		prtln	
		prtln		
		printf "Frequencia: "
		prthex32 freq
		printf " Hz"
		prtln									
		
		jmp end
	rtcinprogress:
		printf "RTC - Atualização em progresso.. !"
		jmp end
	overflow:
		printf "Overflow.. !"
		jmp end		
	fail:
		printf "Houve uma falha.. !"
	end:
		
	jmp $			