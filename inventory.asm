[BITS 16]
[GLOBAL inventory]

extern sys_write
extern sys_read
extern clear_src

extern wepon_player
extern clothes_player

extern wepon_AI
extern clothes_AI

extern armor_player
extern armor_AI

inventory:
	xor ax, ax
	mov ds, ax
	mov es, ax
; PRINT INVENTORY PLAYER
ip:
	call clear_src

	mov si, player_AI_in
	call sys_write
ip_1:
	xor ax, ax
	int 0x16

	cmp al, '1'
	je player_in

	cmp al, '2'
	je AI_in

	cmp al, 'q'
	je back

	jmp ip_1

player_in:
	call clear_src

	mov si, player_in_msg
	call sys_write

        mov si, player_in_msg_1
        call sys_write

        mov si, player_in_msg_2
        call sys_write

	mov si, player_in_msg_3
	call sys_write

        mov si, player_in_msg_4
        call sys_write

        mov si, player_in_msg_5
        call sys_write

        mov si, player_in_msg_6
        call sys_write

	xor ax, ax
	int 0x16

	cmp al, '1'
	je wepon_player_1

	cmp al, '2'
	je clothes_player_1

	cmp al, '3'
	je armor_player_1

	cmp al, 'q'
	je ip

wepon_player_1:
	call wepon_player
	jmp player_in

clothes_player_1:
	call clothes_player
	jmp player_in

armor_player_1:
	call armor_player
	jmp player_in













AI_in:
	call clear_src

	mov si, AI_in_msg
	call sys_write

        mov si, AI_in_msg_1
        call sys_write

        mov si, AI_in_msg_2
        call sys_write

	mov si, AI_in_msg_3
	call sys_write

        mov si, AI_in_msg_4
        call sys_write

	xor ax, ax
	int 0x16

	cmp al, '1'
	je wepon_AI_1

	cmp al, '2'
	je clothes_AI_1

	cmp al, '3'
	je armor_AI_1

	cmp al, 'q'
	je ip



wepon_AI_1:
	call wepon_AI
	jmp AI_in

clothes_AI_1:
	call clothes_AI
	jmp AI_in
armor_AI_1:
	call armor_AI
	jmp AI_in

















back:
	call clear_src
	ret


; section .data
player_AI_in		db "                               [ 1. Inventory player ]",10,13
			db "                               [ 2. Inventory AI     ]",0

player_in_msg		db "|==============================================================================|",10,13
			db "|                               [  Player Item ]                               |",10,13,0
player_in_msg_1		db "|                               [ 1 . Wepon    ]                               |",10,13,0
player_in_msg_2		db "|                               [ 2 . Clothes  ]                               |",10,13,0
player_in_msg_3		db "|                               [ 3 . Armor    ]                               |",10,13,0
player_in_msg_4		db "|                               [ 4 . Medical  ]                               |",10,13,0
player_in_msg_5		db "|                               [ 5 . Building ]                               |",10,13,0
player_in_msg_6		db "|==============================================================================|",10,13,0


AI_in_msg		db "|==============================================================================|",10,13,0
			db "|                               [   AI Item   ]                                |",10,13,0
AI_in_msg_1	        db "|                               [ 1 . Wepon   ]                                |",10,13,0
AI_in_msg_2     	db "|                               [ 2 . Clothes ]                                |",10,13,0
AI_in_msg_3		db "|                               [ 3 . Armor   ]                                |",10,13,0
AI_in_msg_4		db "|==============================================================================|",10,13,0

num_wepon_player:	times 1 db 0
num_weopn_AI:    	times 1 db 0

num_clothes_player: times 1 db 0
num_closthes_AI:	times 1 db 0
