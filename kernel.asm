[BITS 16]
[GLOBAL start]

extern menu_game
extern menu_calculator
extern menu_learn_app

extern clear_src
extern sys_write

start:
	cli
	xor ax, ax
	mov ds, ax
	mov es, ax

; SET UP STACK IF YOU WANT OS LIVE !!!!
	xor ax, ax
	mov ax, 0x7000
	mov ss, ax
	mov sp, 0xFFFE

; LIVE SUCCESS
input:
	call clear_src

	mov si, menu_msg
	call sys_write
input_1:
	xor ah, ah
	int 0x16

	cmp al, '1'
	je menu_game_app

	cmp al, '2'
	je menu_learning_app

	cmp al, '3'
	je chat_bot

	cmp al, '4'
	je caculator

	jmp input_1

menu_game_app:
	call clear_src
	call menu_game

	jmp start


menu_learning_app:
        call clear_src
	call menu_learn_app

	jmp start

chat_bot:
        call clear_src
	cli
	hlt

caculator:
        call clear_src
	call menu_calculator
	jmp start





; DATA
menu_msg db "*******************************************************************************",13,10
         db "*                                Welcome to My OS                             *",13,10
         db "*******************************************************************************",13,10
	 db "*                                1. Game App                                  *",13,10
         db "*                                2. Learning app about assembly 64 bit        *",13,10
         db "*                                3. Chat Bot                                  *",13,10
	 db "*                                4. Calculator                                *",13,10
	 db "*******************************************************************************",13,10
	 db "Enter numbers from 1-->4 to activate : ",0

