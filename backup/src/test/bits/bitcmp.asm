
%ifndef TEST_BITCMP_MAC
	%define TEST_BITCMP_MAC

	%include "lib/mem.mac"
	%include "lib/stdio.mac"
	%include "lib/bits.mac"
	
section .data

%macro test_bitcmp 0		
	openstack 0Ah
	
	malloc dx, ax, 3				
	push sp
	pop bp
	mov word [bp+0], dx
	mov word [bp+2], ax
	
	mov ds,dx	
	mov si,ax
	mov byte [si+2], 00011100b		
	mov byte [si+1], 00001010b		
	mov byte [si+0], 00000110b						
		
	malloc dx, ax, 3
	push sp
	pop bp
	mov word [bp+4], dx
	mov word [bp+6], ax
		
	mov ds,dx	
	mov si,ax	
	mov byte [si+2], 00011100b		
	mov byte [si+1], 00001001b		
	mov byte [si+0], 00000101b	
			
	push sp
	pop bp
	mov word dx, [bp]
	mov word ax, [bp+2] 
	printbin dx, ax, 3, TRUE
	newline
	push sp
	pop bp
	mov word dx, [bp+4]
	mov word ax, [bp+6] 
	printbin dx, ax, 3, TRUE
	newline
	newline
	
	dec sp
	push sp
	pop bp
	mov byte [bp+9], 3
	call proc_cmpbs
	push sp
	pop bp
	mov byte cl, [bp]
	printbin8 cl, TRUE
	inc sp
			
	closestack 0Ah	
%endmacro

%endif