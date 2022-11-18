
%include "lib/system.mac"
%include "lib/stdio.mac"
%include "lib/math.mac"
%include "lib/float.mac"
		
section .data
	n1: dd 75.0
	n2: dd 90.0
	n3: dd 0
	n4: dd -15.0
	n5: dd 0
section .text
	global _start
	
_start:		
	prtstk
	prtln
	prtln
				
	flsub n1, n2, n3
	fltoint32 n1, n5
		 
	prthex32 n1
	printf " --> "
	prtIEEE754 n1
	prtln
	prthex32 n2
	printf " --> "
	prtIEEE754 n2
	prtln
	prtln
	prthex32 n3
	printf " --> "
	prtIEEE754 n3
	prtln
	prthex32 n4
	printf " --> "
	prtIEEE754 n4
	prtln
	prthex32 n5
	prtln
	prtbin32 n5
	prtln
	
	int32tofl n5
	
	prtIEEE754 n5
	prtln
	 		
	prtln
	prtln
	prtstk			
	
	jmp $		