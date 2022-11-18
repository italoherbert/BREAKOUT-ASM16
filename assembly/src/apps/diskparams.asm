%include "lib/disk.mac"
			
section .text
	global _start
	
_start:	
	printf "DISKETTE"
	prtln
	showdiskparams 00h
	
	prtln
	prtln
	printf "PENDRIVE"
	prtln
	showdiskparams 80h
	mov ah,0
	int 16h
	
	jmp $
