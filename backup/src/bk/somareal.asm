
%include "lib/stdio.mac"
%include "lib/float.mac"
%include "lib/float2.mac"

section .bss
	n1: resd 1
	n2: resd 1
	n3: resd 1
	
section .text
	global _start
	
_start:	
	stosfloat n1, -1000.05
	stosfloat n2, -0.01
	
	mov ax, n1
	lea bx, [n1]
		
	mov word [n3], ax
	printhex16 [n3], TRUE
	newline
	mov word [n3], bx
	printhex16 [n3], TRUE
	
	;movbs n3, n1, 4
	;floatsub n3, n2
	
	;printfloat n2
	;newline
	;printf "-"
	;newline		
	;printfloat n2
	;newline
	;printf "="
	;newline		
	;printfloat n3	
			
	jmp $
