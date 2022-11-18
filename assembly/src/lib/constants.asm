%ifndef CONSTANTS_ASM
	%define CONSTANTS_ASM
					
section .data
	__FL_ZERO: dd 0
	__FL_ONE: dd 0x3F800000
	__FL_NEG_ONE: dd 0xBF800000

	__ZERO: dw 0
	__ONE: dw 1
		
	__ball_color: db 09h
	__ball_bordercolor: db 07h
	
	__tray_color: db 00h
	__tray_bordercolor: db 07h	
	
	__square_bordercolor: db 07h
	__square_ycolor: db 0x01, 0x02, 0x04, 0x09
	
	__racket_color: db 09h
	__racket_bordercolor: db 07h	
	
	__message_default_color: db 07h	
	__message_win_color: db 09h	
	__message_lose_color: db 04h	
								
%endif
