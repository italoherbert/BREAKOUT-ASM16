%ifndef CMPBS_ASM
	%define CMPBS_ASM
	
	%include "lib/sys.mac"
	%include "lib/stdio.mac"

section .data

; proc_cmpbs ( &byte, word, word, word, word, byte )
; 	&byte - resultado (-1, 0, 1) ou (10000001, 0, 00000001)
;	word - segmento do primeiro valor a ser comparado
;	word - offset do primeiro valor a ser comparado
;	word - segmento do segundo valor a ser comparado
;	word - offset do segundo valor a ser comparado
; 	byte - tamanho (em bytes) dos valores comparados
proc_cmpbs:
	mov ax,sp
	mov bp,ax
	
	xor ch,ch
	mov cl,[bp+11]
		
	mov si, [bp+5]
	add si,cx
	
	mov di, [bp+9]
	add di,cx
				
	.l1:
		cmp cl,0
		jz .l2
						
		dec si
		dec di
		
		mov ax, [bp+3]
		mov ds,ax
		mov al, [si]		
		
		mov ax, [bp+7]
		mov ds,ax		
		mov bl, [di]
		
		cmp al, bl
		ja .above
		jb .below
						
		dec cl
		jmp .l1
	.l2:
	
	jmp .equal
	.above:
		mov byte [bp+2], 00000001b
		jmp .endcmp
	.below:
		mov byte [bp+2], 10000001b
		jmp .endcmp
	.equal:
		mov byte [bp+2], 0
	.endcmp:
	
	ret
	
	
; proc_cmpbs ( &byte, word, word, word, word, byte )
; 	&byte - resultado (-1, 0, 1) ou (10000001, 0, 00000001)
;	word - segmento do primeiro valor a ser comparado
;	word - offset do primeiro valor a ser comparado
; 	byte - tamanho (em bytes) do primeiro valor
;	byte - segundo valor a ser comparado (byte em registrador ou constante)
proc_cmpbsb:
	mov ax,sp
	mov bp,ax
	
	mov ax,[bp+3]
	mov ds,ax
	mov si,[bp+5]
			
	mov bl,[bp+8]
	
	cmp byte [si], bl
	ja .above
	jb .below
	jmp .equal
	.above:
		mov byte [bp+2], 00000001b
		jmp .endcmp
	.beloworequal:
		.below:
			mov byte [bp+2], 10000001b
			jmp .endblweq
		.equal:
			mov byte [bp+2], 0
		.endblweq:
		
		mov cl,[bp+7]
		dec cl		
		.l1:
			cmp cl,0
			jz .l2
			
			inc si												
			cmp byte [si], 0
			jnz .above
		
			dec cl
			jmp .l1
		.l2:
		
	.endcmp:		
	
	ret			
						
%endif
