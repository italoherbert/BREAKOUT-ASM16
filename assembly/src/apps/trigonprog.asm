
%include "lib/system.mac"
%include "lib/stdio.mac"
%include "lib/math.mac"
%include "lib/float.mac"
%include "lib/trigon.mac"
		
section .data
	angle: dd 0
	x: dd 0
	y: dd 0
	n4: dd 0
	n5: dd 0
section .text
	global _start
	
_start:		
	prtstk
	prtln
	prtln
	
	%if 0
	mov cx,300
		
	int16to32 cx, angle					
	int32tofl angle, angle		
	toradians angle, angle
	
	cos angle, x
	;sin angle, y		
	
	;prthex32 y
	;printf "  "
	;fltoint32 x,x
	prthex32 x
	%endif
	
	;%if 0
	mov cx,180
	l1:
		cmp cx,360
		jg l2
		push cx
		
		pusha
		prthex16 cx
		printf " --> "
		popa
		
		int16to32 cx, angle					
		int32tofl angle, angle		
		toradians angle, angle
		
		cos angle, x
		sin angle, y		
		
		prthex32 y
		printf "  "
		prthex32 x
		prtln
		
		pop cx
		add cx,30
		jmp l1
	l2:
	;%endif
						 		
	prtln
	prtln
	prtstk			
	
	jmp $		