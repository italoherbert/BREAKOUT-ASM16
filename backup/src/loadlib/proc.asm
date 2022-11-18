
[map symbols labels.map]

section .data	
	lib: incbin "bin/lib.bin"

section .text
	global _start
	
_start:
	mov ax,cs
	mov ds,ax
	mov si, lib
	
	mov ax, 0x9000
	mov es,ax
	mov di, 0x0050
	
	mov cl,0Ah
	l1:
		cmp cl,0
		jz l2
		
		lodsb	
		stosb
		
		dec cl
		jmp l1
	l2:
	
	mov ah,0Eh
	mov al, 'A'
	mov bh,0
	int 10h
	
	mov ah,0Eh
	mov al, ' '
	mov bh,0
	int 10h
	
	mov dx, 0x1000
	mov ds,dx
	mov si, 0x0000
	
	mov word [si], 0x0050
	mov word [si+2], 0x9000
	
	call far [si]

	mov ah,0Eh
	mov al, ' '
	mov bh,0
	int 10h
	
	mov ah,0Eh
	mov al, 'C'
	mov bh,0
	int 10h

	jmp $