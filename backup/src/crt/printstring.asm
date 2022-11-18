%include "crt/crt.mac"

section .text
	global _start
	
_start:				
	jmp $

section .data
	msg: db "Funcionou !",0