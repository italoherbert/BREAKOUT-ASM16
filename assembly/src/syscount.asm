
%include "lib/stdio.mac"
%include "lib/math.mac"

section .data	
	aux: dd 0
	aux2: dd 0
	ticks: dd 0
	sleep: dd 1000000
	count: dw 20
	
section .text
	global _start
	
_start:	
	mov ax,cs
	mov ds,ax

	init:
	
	mov ah,00h
	int 1Ah
	jc fail
	
	cmp al,0
	jz scok
	jmp overflow		
						
	scok:		
		mov word [ticks+2],cx
		mov word [ticks],dx
		
		sub32 ticks, aux, aux
				
		printf "Numero de tics desde as 0:00 horas: "
			
		prthex32 ticks
		printf " --> "
		prthex32 aux
		prtln
		
		mov32 aux, ticks
		
		mov ah,86h
		mov cx,[sleep+2]
		mov dx,[sleep]
		int 15h		
		
		dec16 count							
		int16toreg count, ax
		cmp ax,0
		jz end
		jmp init
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