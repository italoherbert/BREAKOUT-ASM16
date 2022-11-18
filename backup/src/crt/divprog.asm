%include "lib/crt.mac"
%include "lib/string.mac"

section .bss
	str: resb 5

section .text
	global _start
	
_start:
	inittextmode
		
	mov dx,0001h	
	mov ax,0005h
		
	mov cx,10h
	div cx
		
	push dx
	push ax	
			
	writestr "AX="
	pop ax		
	writehex ax
	write 0
	writestr "DX="
	pop dx
	writehex dx
	newline
	
	print 'A','B','C','D'
	
	newline
	newline
	
	;mov ax,0xFFFF
	;mov bx,0xFFFF
	;mov cx,0xFFFF
	;mov dx,0xFFFF
		
	hextostr str,1ACFh 
	
	push si
	
	mov si,str
	next:
		lodsb
		cmp al,0
		je end
		
		write al
		jmp next
	end:
	
	pop si
	
	newline
	;writehex ax
	;writehex bx
	;writehex cx
	;writehex dx	

	jmp $