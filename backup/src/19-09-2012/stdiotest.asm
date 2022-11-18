
[map symbols map/labels.map]

%include "lib/stdio.mac"
%include "lib/strings.mac"
%include "lib/mem.mac"

section .text
	global _start
	
_start:
	initmem
	
	printf "stack ---> "
	mov ax,sp
	printhex16 ax
	newline	 	
	newline
	
	printhex8 02h
	printhex8 34h, FALSE
	printhex8 0Dh, TRUE	
	
	newline
	
	printhex16 0204h, TRUE
	newline
	printhex16 0204h, FALSE
	newline
	printhex16 0204h
			
	malloc dx, si, 6
	mov ds, dx
	mov byte [si+0], 9Ah
	mov byte [si+1], 08h
	mov byte [si+2], 06h
	mov byte [si+3], 34h
	mov byte [si+4], 12h
	mov byte [si+5], 00h
	mov ax,si
	push dx
	push ax
	
	newline
	pop ax
	pop dx
	push dx
	push ax
	printhex dx, ax, 6, TRUE	
	newline
	pop ax
	pop dx
	push dx
	push ax	
	printhex dx, ax, 6, FALSE
	newline	
	pop ax
	pop dx
	push dx
	push ax	
	printhex dx, ax, 6
	newline
			
	printhex16 000Ah, FALSE
	printf " ---> "
	printbin16 000Ah, TRUE
	printf " ---> "
	printbin16 000Ah, FALSE
	newline
	newline
		
	pop ax
	pop dx
	push dx
	push ax	
	printhex dx, ax, 6, TRUE
	newline
	pop ax
	pop dx
	push dx
	push ax	
	printbin dx, ax, 6, TRUE
	newline
	pop ax
	pop dx
	printbin dx, ax, 6
	newline		
	newline
		
	malloc dx, ax, 10
	push dx
	push ax
	strld dx, ax, "Teste STRINGS..."
	pop ax
	pop dx
	push dx
	push ax
	printstr dx, ax
	newline
	printf "LENGHT: "
	pop ax
	pop dx
	strlen bl, dx, ax
	printhex8 bl	
	newline
	
	newline
	printf "stack ---> "
	mov ax,sp
	printhex16 ax
	newline		
				
	jmp $
	