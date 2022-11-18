
%ifndef TEST_BITCMP8_MAC
	%define TEST_BITCMP8_MAC

	%include "lib/mem.mac"
	%include "lib/stdio.mac"
	%include "lib/bits.mac"
	%include "lib/test/tunit.mac"

%macro test_bitcmp8 0		
	testunit al, cs, proc_testbitcmp8, cs, file, TRUE	
	
	push ax
	newline
	pop ax
	
	cmp al, TRUE
	je .true
	jmp .false
	.true:
		printf "Todos os testes passaram..."
		jmp .endcmp
	.false:
		printf "Um ou mais testes falharam..."
	.endcmp:
%endmacro
		
section .data
	file: incbin "src/test/bits/testcase/bitcmp8.dat"		

proc_testbitcmp8:	
	mov ax,sp
	mov bp,ax
	
	mov dx,[bp+8]
	mov si,[bp+0x0A]	
	mov ds,dx
	mov byte bh, [si]
			
	mov dx,[bp+0x0D]
	mov si,[bp+0x0F]	
	mov ds,dx
	mov byte bl, [si]
		
	mov dx,[bp+3]
	mov ax,[bp+5]
	
	push bx
	cmpbsb cl, dx, ax, 3, bh
	pop bx
	
	mov ax,sp
	mov bp,ax
		
	cmp cl,bl
	je .ok
	jmp .fail
	.ok:
		mov byte [bp+2], TRUE
		writechar 'O'
		writechar 'K' 
		jmp .endtest
	.fail:
		mov byte [bp+2], FALSE
		writechar 'F'
		writechar 'A' 
		writechar 'L'
		writechar 'H'
		writechar 'A' 
	.endtest:	
			
	ret

%endif