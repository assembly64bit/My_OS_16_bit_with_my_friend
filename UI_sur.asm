[BITS 16]
[GLOBAL UI_sur]
extern clear_src
extern sys_write
extern play
UI_sur:
	xor ax, ax
	mov ds, ax
	mov es, ax

	mov si, UI_msg
	call sys_write
ip:
	xor ax, ax
	int 0x16

	cmp al, '1'
	je Play

	cmp al, '2'
	je GI

	cmp al, '3'
	je IC

	cmp al, '4'
	je back_to_menu

	jmp ip


Play:
	call clear_src
	call play
	jmp UI_sur

GI:
IC:
back_to_menu:
	call clear_src
	ret

















































; SECTION .DATA
UI_msg 	 db "*******************************************************************************",13,10
         db "*                                Menu game Survival                           *",13,10
         db "*******************************************************************************",13,10
         db "*                                1. Play                                      *",13,10
         db "*                                2. Game Instructions                         *",13,10
         db "*                                3. Info Character                            *",13,10
         db "*                                4. Back to menu                              *",13,10
         db "*******************************************************************************",13,10
         db "Enter numbers from 1-->3 to activate : ",0
