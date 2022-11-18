%include "lib/system.mac"
%include "lib/stdio.mac"
%include "lib/math.mac"
%include "lib/float.mac"
%include "lib/trigon.mac"
%include "lib/graph.mac"

section .data
	xc: dw 100
	yc: dw 100
	r: dw 50
	color1: db 04h
	color2: db 07h

section .text
	global _start
	
_start:		
	initgraph
		
	fillarc xc, yc, r, r, color1						
	drawarc xc, yc, r, r, color2	
	repaint
	
	jmp $
