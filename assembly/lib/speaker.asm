
%ifndef SPEAKER_ASM
	%define SPEAKER_ASM
	
section .data

proc_speaker_init:
	mov al,10110110b
	out 43h, al	
	
	ret

proc_speaker_start:
	in al, 61h
	or al, 0x03
	out 61h, al
	
	ret	
	
proc_speaker_setf:
	mov ax,sp
	mov bp,ax
	
	mov bx,[bp+2]
	mov dx, 0012h
	mov ax, 34DCh
	div bx
	
	out 42h, al
	mov al, ah
	out 42h, al
	
	ret
	
proc_speaker_stop:
	in al, 61h
	and al, 0xFC
	out 61h, al

	ret
	
	
%endif