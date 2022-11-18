%include "lib/strings.mac"
%include "lib/math16.mac"

section .bss
	n1: resw 5
	n2: resw 5
	hexn1: resw 1
	hexn2: resw 1
	result: resw 1

section .text
	global _start	
	
_start:				
	printf "Informe um numero: "
	scanfint n1
	printf "Informe outro numero: "
	scanfint n2
	newline
	
	asciitointhex16 hexn1, n1
	asciitointhex16 hexn2, n2
	
	printhex [hexn1]
	newline
	printhex [hexn2]
	
	mov word ax,[hexn2]
	add word [hexn1], ax
	
	hex16toascii result, [hexn1]
	
	newline
	printstr n1
	printf " + "
	printstr n2
	printf " = "
	printstr result
	
	jmp $
	