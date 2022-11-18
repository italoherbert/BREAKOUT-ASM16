%include "lib/math16.mac"
%include "lib/stdio.mac"

section .bss
	exp: resw 2
	n: resw 1
	n2: resw 1
	hexstr: resb 5
	nibble: resb 1	

section .text
	global _start
	
_start:
	printhex 0x270F
	newline
	hex16tohexint exp,0x270F
	
	hex16toascii hexstr, [exp]
	
	printstr hexstr
	newline
	newline

	printf "Informe um numero: "
	scanfint hexstr

	newline
	printf "Numero lido: "
	printstr hexstr
	newline
	
	mov word [exp],0000h
			
	asciitointhex16 exp, hexstr
		
	printf "Convertido para hexadecimal: "	
	printhex [exp]
		
	jmp $