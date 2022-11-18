%include "lib/stdio.mac"
%include "lib/system.mac"
%include "lib/math.mac"
%include "lib/speaker.mac"

section .data
	SLEEP: dd 500000
	COUNT: dw 8
	FREQ: dw 1000
	FREQINC: dw 100
	FREQINC2: dw 1000

	sleep: dd 0
	freq: dw 0
	freqinc: dw 0
	count: dw 0

section .text
	global _start
	
_start:		
	mov16 freq, FREQ

	speaker_init
	
	tocar:
	mov32 sleep, SLEEP
	mov16 count, COUNT
	mov16 freqinc, FREQINC
	
	speaker_start	
	printf "Tocando "	
	
	l1:
		int16toreg count, cx
		cmp cx,0
		jz l2
		
		int16toreg freq, ax
		prthex16 ax
		prtch 20h
						
		speaker_setf freq 
				
		delay sleep		
		
		add16 freq, freqinc
		
		dec16 count
		jmp l1
	l2:
	
	speaker_stop
	
	add16 freq, FREQINC2 
	
	printf " (ESQ) - Sair"
	prtln
	mov ah,00h
	int 16h
	cmp al,27
	jne tocar
	
	printf "Saindo...."
	
	int 19h 	
	
	jmp $
