%include "src/lib/game.mac"
%include "src/lib/gui.mac"
		
section .data
	i: dw 0
	n: dw 10
	aux: dw 0
	reinited: dw 0
	delay: dd 1	
section .text
	global _start
	
_start:
	initgraph
	
	init:
		cmp16 reinited, __ONE, cl
		push cx
		cmp cl,0
		jz initandpaint
			game_show_init_message
			
		initandpaint:
			game_initialize
			game_paint
			
		pop cx
		cmp cl,0
		jz run
			mov ah,00h
			int 16h
			game_hide_init_message			
	run:
		game_status cl
		cmp cl,1
		je win
		cmp cl,2
		je lose
		jmp playering
		win:
			game_show_win_message
			jmp finish
		lose:
			game_show_lose_message
			jmp finish
		playering:
					
		game_moveball
		
		mov16 aux, i
		mod16 aux, n
				
		int16toreg aux, ax
		cmp ax,0
		jnz painted
			game_paint
		painted:
		
		mov ah,11h		
		int 16h
		jz continue					
			mov ah,00h
			int 16h
			cmp al,27
			je init
			cmp al,13
			je enter
			cmp al,0
			je specialch
			jmp continue					
			
			enter:
				game_show_pause_message
				game_paint
				waitenter:
					mov ah,00h
					int 16h					
					cmp al,13
					jne waitenter
				game_hide_pause_message
				jmp continue
			specialch:
				cmp ah,4Bh
				je back
				cmp ah,4Dh
				je front
				jmp continue
				back:
					game_backmoveracket				
					jmp continue
				front:
					game_frontmoveracket				
										
		continue:	
		
		mov ah,86h
		int16toreg delay+2, cx
		int16toreg delay, dx
		int 15h
		
		inc16 i
		jmp run
	
	finish:		
		game_paint
		mov ah,00h
		int 16h
	
		mov16 reinited, __ONE
		jmp init
	
	jmp $
