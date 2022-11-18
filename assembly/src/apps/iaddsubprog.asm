
%include "lib/system.mac"
%include "lib/stdio.mac"
%include "lib/math.mac"
%include "lib/float.mac"

section .data
	n1: dd 0
	n2: dd 0
	n3: dd 0
		
section .text
	global _start
	
_start:		
	prtstk
	prtln
	prtln
	
	mov ax,0xFFFA
	mov bx,0x000A
	push bx
	push ax
		
	add ax,bx
				
	prthex16 ax			
	prtln
			
	pop ax	
	__int16to32 ax, bx, cx
	mov ax,cs
	mov ds,ax
	mov [n1+2],bx
	mov [n1],cx
			
	pop ax	
	int16to32 ax, n2
	
	iadd32 n1, n2, n3
	
	int32to16 n3, ax
	prthex16 ax
	prtln
	prtln
	prthex32 n1
	prtln
	prthex32 n2
	prtln
	prthex32 n3	  	
	
	prtln
	prtln
	prtstk			
	
	jmp $		