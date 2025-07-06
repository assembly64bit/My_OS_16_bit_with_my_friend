[BITS 16]
[GLOBAL clothes_player]

extern sys_write
extern clear_src

clothes_player:
	call clear_src
;----------------------------------------------------
	mov si, clothing_1
	call sys_write

	mov si, clothing_h
	call sys_write

;-------------------------------------------------
        mov si, clothing_2
        call sys_write

        mov si, clothing_b
        call sys_write
;------------------------------------------------
        mov si, clothing_3
        call sys_write

        mov si, clothing_ha
        call sys_write
;------------------------------------------------
        mov si, clothing_4
        call sys_write

        mov si, clothing_l
        call sys_write
;-------------------------------------------
        mov si, clothing_5
        call sys_write

        mov si, clothing_f
        call sys_write
;-------------------------------------------
	xor ax, ax
	int 0x16

	cmp al, 'q'
	je back

back:
	call clear_src
	ret




























clothing_1 	db " Head : ",0
clothing_2	db " Body : ",0
clothing_3	db " Hand : ",0
clothing_4	db " Leg  : ",0
clothing_5	db " Feet : ",0

clothing_h	db 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,10,13,0

clothing_b	db 'S' , 'H', 'I', 'R', 'T',0x20,0x20,0x20,0x20,0x20,10,13,0

clothing_ha	db 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,10,13,0

clothing_l	db 'J' , 'E', 'A', 'N', 'S',0x20,0x20,0x20,0x20,0x20,10,13,0

clothing_f	db 'S' , 'H', 'O', 'E', 'S',0x20,0x20,0x20,0x20,0x20,10,13,0
