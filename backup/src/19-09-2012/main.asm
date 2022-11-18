
%include "lib/system.mac"
%include "lib/stdio.mac"
%include "lib/math.mac"
		
section .data
	n1: dd 0xF0FFAAA9
	n2: dd 0xF0FFAAA9
	n3: db 0x0		
	n4: db 00011101b
	n5: dd 4.0082
		
section .text
	global _start
	
_start:			
	cmp32 n1, n2, cl
	mov byte [n3],cl
	
	printf "stack ---> "
	mov ax,sp
	prthex16 ax
	prtln	 	
	prtln
		
	prtzhex32 n1
	prtln	
	shl32 n1, 20	
	prtzhex32 n1
	prtln
	
	prtzhex32 n2
	prtln
	shr32 n2, 20
	prtzhex32 n2
	prtln
	
	prtln
	mov cl, [n3]
	prtzbin8 cl
	prtln
	prtln
	prtln
	
	mov al,[n4]
	prtzbin8 al
	prtln
	
	mov al,[n4]
	prtsubbin8 al, 0, 1
	prtln
	
	mov al,[n4]
	prtsubbin8 al, 1, 4
	prtln
	
	mov al,[n4]
	prtsubbin8 al, 4, 8
	prtln
	prtln
	
	prtzhex32 n5
	prtln
	prtzbin32 n5
	prtln
	prtIEEE754 n5
					
	prtln
	prtln
	printf "stack ---> "
	mov ax,sp
	prthex16 ax
		
	jmp $		