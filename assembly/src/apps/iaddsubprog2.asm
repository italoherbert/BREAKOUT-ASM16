
%include "lib/system.mac"
%include "lib/stdio.mac"
%include "lib/math.mac"
		
section .data
	n1: dd 0x2
	n2: dd 0x6
	n3: dd 0
	n4: dd 0
	err: db 0		
		
section .text
	global _start
	
_start:		
	prtstk
	prtln
	prtln
	
	setsig n1
		
	isub32 n1, n2, n3
	
	prtbin32 n1
	prtln
	prtbin32 n2
	prtln
	prtbin32 n3	
	prtln
	prtln
	
	iprthex32 n1
	prtln
	iprthex32 n2
	prtln
	iprthex32 n3			
		
	prtln
	prtln
	prtstk			
	
	jmp $		