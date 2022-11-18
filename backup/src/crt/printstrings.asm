%include "lib/stdio.mac"

section .bss
	v1: resw 1
	v2: resw 1
	v3: resw 1
	v4: resw 1
	count: resb 1
	
	str1: resb 5
	str2: resb 5
	str3: resb 5
	str4: resb 5
	
	msg1: resb 50
	msg2: resb 50
	msg3: resb 50

section .text
	global _start

_start:		
	
	mov word [v1],0x0123
	mov word [v2],0x4567
	mov word [v3],0x89AB
	mov word [v4],0xCDEF
	;not word [v1]
	;not word [v2]
	;not word [v3]
	;not word [v4]
	
	mov byte [count],4		
	
	loop1:
		cmp byte [count],0
		jz endloop

		strload msg1, "V1="
		strload msg2, "V2="		
		strload msg3, "V3="
		hextostr str1, [v1]
		hextostr str2, [v2]
		hextostr str3, [v3]					
		printf msg1,str1
		newline
		printf msg2,str2
		newline
		printf msg3,str3
		newline
				
		dec byte [count]
	jmp loop1
	endloop:
						
	jmp $
	