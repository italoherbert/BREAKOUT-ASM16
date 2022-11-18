
%include "lib/system.mac"
%include "lib/stdio.mac"
%include "lib/math.mac"
		
section .data
	n1: dd 0x7df890ed
	n2: dd 0x00309f7C
	n3: dd 0
	n4: dd 0
	err: db 0		
		
section .text
	global _start
	
_start:		
	prtstk
	prtln
	prtln
		
	div32 n1, n2, n3, n4, err
	
	prtbin32 n1
	prtln
	prtbin32 n2
	prtln
	prtbin32 n3	
	prtch 20h
	prtbin32 n4
	prtln
	prtln
	
	prthex32 n1
	prtln
	prthex32 n2
	prtln
	prthex32 n3	
	prtch 20h
	prthex32 n4
	prtln
	mov ax,cs
	mov ds,ax
	mov al,[err]
	prthex8 al			
		
	prtln
	prtln
	prtstk			
	
	jmp $		