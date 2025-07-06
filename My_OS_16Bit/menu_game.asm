[BITS 16]
[GLOBAL menu_game]

extern sys_write
extern clear_src

extern guess_num
extern x_o
extern menu_2048_mode
extern UI_sur

menu_game:
	xor ax, ax
	mov ds, ax
	mov es, ax

	call clear_src
	mov si, menu_game_msg
	call sys_write
; READ
read:
	xor ah, ah
	int 0x16

	cmp al, '1'
	je guess_game

	cmp al, '2'
	je x_o_game

	cmp al, '3'
	je game_2048

	cmp al, '4'
	je sur_game

	cmp al, '5'
	je back_to_menu

	jmp read

guess_game:
	call clear_src
	call guess_num
	jmp menu_game

x_o_game:
	call clear_src
	call x_o
	jmp menu_game


game_2048:
	call clear_src
	call menu_2048_mode
	jmp menu_game
sur_game:
	call clear_src
	call UI_sur
	jmp menu_game

back_to_menu:
	call clear_src
	ret

























; DATA
menu_game_msg db "*******************************************************************************",13,10
              db "*                                Welcome to Game-App                          *",13,10
              db "*******************************************************************************",13,10
              db "*                                1. Guess_num                                 *",13,10
              db "*                                2. Caro_chess                                *",13,10
              db "*                                3. Game_2048_limited_on_OS                   *",13,10
              db "*                                4. Survival_Game                             *",13,10
	      db "*                                5. Back_to_menu                              *",13,10
              db "*******************************************************************************",13,10
              db "Enter numbers from 1-->4 to play_game : ",0

