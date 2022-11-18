
%include "lib/system.mac"
%include "lib/stdio.mac"
	
section .text
	global _start
	
_start:		
	printf "stack ---> "
	mov ax,sp
	printhex16 ax
	newline	 	
	newline
	
	openstack 0Fh
	mov word [ bp + 0 ], 0x0151
	mov word [ bp + 2 ], 0x0002
	mov word [ bp + 4 ], 0x0000
	mov word [ bp + 6 ], 0x0005
		
	mov word dx, [bp+2]
	mov word ax, [bp+0]
	push bp	
	laddr ax, dx
	pop bp	
	mov word [ bp + 0x08 ], ax
	mov word [ bp + 0x0A ], dx
	
	mov word dx, [bp+0x08]
	mov word ax, [bp+0x0A]
	push bp	
	faddr dx, ax
	pop bp	
	mov word [ bp + 0x0C ], dx
	mov word [ bp + 0x0E ], ax
	
	
	push sp
	pop bp	
	mov ax, [bp+0]
	mov dx, [bp+2]
	printfptr ax, dx
	newline
	
	push sp
	pop bp	
	mov ax, [bp+0x0A]
	mov dx, [bp+0x08]
	printptr dx, ax
	newline
	
	push sp
	pop bp	
	mov ax, [bp+0x0C]
	mov dx, [bp+0x0E]
	printfptr ax, dx
	newline
	newline		
	
	push sp
	pop bp
	mov word ax, [ bp + 0 ]
	mov word bx, [ bp + 2 ]
	mov word cx, [ bp + 4 ]
	mov word dx, [ bp + 6 ]
	mformat ax, bx, cx, dx
							
	push sp
	pop bp
	mov word ax, [ bp + 0 ]
	mov word bx, [ bp + 2 ]	
	malloc ax, bx, ax, bx, 0xFFFF, dl	
	
	push sp
	pop bp
	mov word [ bp + 8 ], ax
	mov word [ bp + 0x0A ], bx
	

	cmp dl,0
	jz enderror
		printf "Overflow... ERRO: "
		printhex8 dl
		newline
		newline
	enderror:
						
	push sp
	pop bp
	mov word ax, [ bp + 8 ]
	mov word dx, [ bp + 0x0A ]	
	printptr ax, dx
	printf " ate "
	
	push sp
	pop bp
	mov word ax, [ bp + 0 ]
	mov word dx, [ bp + 2 ]		
	laddr ax,dx	
	mov ds,ax
	mov si,dx
			
	mov ax, [si]
	mov dx, [si+2]
	laddr ax,dx
	printptr ax, dx
				
	closestack 0Fh
				
	newline
	newline
	printf "stack ---> "
	mov ax,sp
	printhex16 ax
	

	jmp $