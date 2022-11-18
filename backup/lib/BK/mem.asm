
%ifndef MEMORY_ASM
	%define MEMORY_ASM
	
	%include "lib/sys.mac"
	
section .data	
	
	MEM_SEG: equ 0x0050				; MEM Fisica 0x0500
	
	INITIAL_MEM_HIGH_POINT: equ 0x0000	; MEM Fisica 0x00001500 (Parte alta)
	INITIAL_MEM_LOW_POINT: 	equ 0x1500	; MEM Fisica 0x00001500 (Parte baixa) 

	MEM_PPOINT: equ 0x0000					; Offset do Segmento MEM_SEG 
											; com conteúdo [ SEGMENT:OFFSET 32 bits (2 words) ]

proc_initmem:
	mov ax,sp
	mov bp,ax

	mov word dx, [bp+6]
	mov word ax, [bp+4]	
	mov bx, 10h
	div bx
	
	mov ds, ax
	mov si, dx
	
	mov word ax, [bp+6]
	mov word dx, [bp+4]	
	
	add dx, 0x08
	adc ax, 0			
	
	mov word [ si + 0 ], dx	
	mov word [ si + 2 ], ax
	
	mov word dx, [bp+0x0A]
	mov word ax, [bp+8]
	
	mov word [ si + 4 ], ax
	mov word [ si + 6 ], dx
		
	retf

proc_malloc:
	mov ax,sp
	mov bp,ax
			
	mov ax, [bp+4]
	mov ds, ax
	mov si, [bp+6]
				 	
	mov ax,sp
	mov bp,ax
	mov byte cl, [ bp + 6 ]
	xor ch,ch
		
	mov word dx, [ MEM_PPOINT + 2 ]
	mov word ax, [ MEM_PPOINT + 0 ]
	mov bx,10h
	div bx
	
	mov bx,cx
	add bx,dx
	jnc .abovethrowed
		inc ax
		mov dx, 0x0000						
	.abovethrowed:

	mov word [ bp + 2 ], ax
	mov word [ bp + 4 ], dx

	add cx,dx

	xor dx,dx
	mov bx,10h
	mul bx	
	
	add ax,cx
	adc dx,0
	
	mov word [ MEM_PPOINT + 2 ], dx
	mov word [ MEM_PPOINT + 0 ], ax	
			
	ret
	
%endif