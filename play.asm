[BITS 16]
[GLOBAL play]

extern sys_write
extern sys_read
extern clear_src
extern sys_draw
extern inventory

play:
	xor ax, ax
	mov ds, ax
	mov es, ax

	call clear_src

	mov si, map_data
	mov byte [si], 'X'

	mov si, map_data

	mov si, map_data
	mov byte [si+930], 'A'
ip:

	mov si, map_data
	call sys_draw

	jmp check_friend
ip_1:

	xor ax, ax
	int 0x16
; UP
	cmp ah, 48h
	je print_up
; DOWN
	cmp ah, 50h
	je print_down
; LEFT
	cmp ah, 4Bh
	je print_left
; RIGHT
	cmp ah, 4Dh
	je print_right

        cmp al, 'i'
        je inventory_player_and_AI

	cmp al, 'q'
	je back

	jmp ip_1

;---------------------------------------------------------------------
; PLAYER
print_up:

	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx

	mov si, map_data
	mov di, map_data

; Lấy chỉ số x,y ban đầu

	mov ax, [line]
	mov bx, [cols]

; ax*80+bx

	imul ax, 80

	add ax, bx
	add si, ax

	mov cl, [si]
;-----------------------------------------------------------------------
	mov ax, [line]
	mov bx, [cols]

	dec ax			; giảm dòng

	cmp ax, 0
	jl ip_1
; SAVE
	mov [line], ax
	mov [cols], bx

	imul ax, 80

	add ax, bx
	add di, ax

	mov dl, [di]

	mov [di], cl
	mov [si], dl

	jmp ip
;-----------------------------------------------------------------------
print_down:

        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor dx, dx

        mov si, map_data
        mov di, map_data
; Lấy chỉ số x,y ban đầu

        mov ax, [line]
        mov bx, [cols]

; ax*80+bx

        imul ax, 80

        add ax, bx
        add si, ax

        mov cl, [si]
;-----------------------------------------------------------------------
        mov ax, [line]
        mov bx, [cols]

        inc ax                  ; tăng dòng

	cmp ax, 25
	jge ip_1
; SAVE
        mov [line], ax
        mov [cols], bx

	imul ax, 80
        add ax, bx
        add di, ax

        mov dl, [di]

        mov [di], cl
        mov [si], dl

        jmp ip
;--------------------------------------------------------------------
print_left:
        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor dx, dx

        mov si, map_data
        mov di, map_data
; Lấy chỉ số x,y ban đầu

        mov ax, [line]
        mov bx, [cols]

; ax*80+bx

        imul ax, 80

        add ax, bx
        add si, ax

        mov cl, [si]
;-----------------------------------------------------------------------
        mov ax, [line]
        mov bx, [cols]

        dec bx                  ; giảm cột

        cmp bx, 0
        jl ip_1
; SAVE
        mov [line], ax
        mov [cols], bx

        imul ax, 80

        add ax, bx
        add di, ax

        mov dl, [di]

        mov [di], cl
        mov [si], dl

        jmp ip
;---------------------------------------------------------------
print_right:

        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor dx, dx

        mov si, map_data
        mov di, map_data
; Lấy chỉ số x,y ban đầu

        mov ax, [line]
        mov bx, [cols]

; ax*80+bx

        imul ax, 80

        add ax, bx
        add si, ax

        mov cl, [si]
;-----------------------------------------------------------------------
        mov ax, [line]
        mov bx, [cols]

        inc bx                  ; tăng dòng

        cmp bx, 80
        jge ip_1
; SAVE
        mov [line], ax
        mov [cols], bx

        imul ax, 80

        add ax, bx
        add di, ax

        mov dl, [di]

        mov [di], cl
        mov [si], dl

        jmp ip



;-----------------------------------------------
check_friend:
; check_flags

	xor ax, ax
	mov ax, [flags]

	cmp ax, 1
	je print_place_friend
; JNE
	mov ax, [line]
	mov bx, [cols]

	imul ax, 80
	add ax, bx

	cmp ax, 850
	je checked

	cmp ax, 929
	je checked

	cmp ax, 931
	je checked

	cmp ax, 1010
	je checked
; JNE
	jmp ip_1

; Nếu đã gặp thì cho flags = 1
checked:
	mov word [flags], 1

	call clear_src
	call chat

; Lưu vị trí hiện tại AI

	mov word [line_AI], 11
	mov word [cols_AI], 50

	jmp ip_1
;---------------------------------------------

print_place_friend:

; lấy vị trí hiện tại của AI
	xor ax, ax
	xor bx, bx
	mov si, map_data

	mov ax, [line_AI]
	mov bx, [cols_AI]

	imul ax, 80
	add ax, bx
	add si, ax

	mov cl, [si]
;---------------------------------------------
	xor ax, ax
	xor bx, bx

	mov di, map_data

	mov ax, [line]
	mov bx, [cols]

	sub ax, 2
	sub bx, 2

	cmp ax, 0
	jl ip_1

	cmp bx, 0
	jl ip_1

	imul ax, 80
	add ax, bx
	add di, ax

	mov dl, [di]
; SWAP
	mov [si], dl
	mov [di], cl

	mov ax, [line]
	mov bx, [cols]

	sub ax, 2
	sub bx, 2

	mov [line_AI], ax
	mov [cols_AI], bx

	mov si, map_data
	call sys_draw

	jmp ip_1
;------------------------------------------------
chat:
	mov si, chat_msg_X_1
	call sys_write

	call delay

	mov si, chat_msg_A_1
	call sys_write

	call delay

	mov si, chat_msg_A_2
	call sys_write

	call delay

	mov si, chat_msg_X_2
	call sys_write

	call delay

	mov si, chat_msg_X_3
	call sys_write

	call delay

	mov si, chat_msg_A_3
	call sys_write

	call delay

	call clear_src

	mov si, chat_end
	call sys_write

	call delay
	call clear_src

	mov si, map_data
	call sys_draw

	ret
;----------------------------------------------------
inventory_player_and_AI:
	call inventory

	mov si, map_data
	call sys_draw

	jmp ip_1





















;---------------------------------------------------
delay:
        mov bx, 500
delay_1:
        mov cx, 0xFFFF
loop_delay_1:
        xor ax, ax
        add ax, ax
        add ax, dx
        add ax, ax
        add ax, dx
        xor ax, ax
        xor dx, dx
        mul ax
        mul ax
        mul ax
        mul ax
        mul ax
        mul ax
	mul ax
	mul ax


        loop loop_delay_1
        dec bx

        test bx, bx
        jnz delay_1
        ret
;-------------------------------------------
delay_run:
        mov bx, 100
delay_run_1:
        mov cx, 0xFFFF
loop_delay_run:
        xor ax, ax
        add ax, ax
        add ax, dx
        add ax, ax
        add ax, dx
        xor ax, ax
        xor dx, dx
        mul ax
        mul ax
        mul ax
        mul ax
        mul ax
        mul ax
        mul ax
        mul ax


        loop loop_delay_run
        dec bx

        test bx, bx
        jnz delay_run_1
        ret
;---------------------------
back:
	call clear_src
	ret


; section data
map_data        db 80*25 dup(0x20)     ; full 80x25 space tile map
                db 0

chat_msg_X_1	db "[X] : Are you... are you human ?",10,13,0

chat_msg_X_2	db "[X] : I was the lucky one to survive this disaster... but I lost everything...",10,13,0

chat_msg_X_3	db "[X] : Do you want to accompany me... ",10,13,0

chat_msg_A_1 	db "[A] : No .. I'm a robot... I'm lucky to be alive and have evolved to adapt to", 10,13
	        db "      the post apocalypse..", 10,13, 0


chat_msg_A_2	db "[A] : And... you... who are you ? ",10,13,0
chat_msg_A_3	db "[A] : ... Ok ...",0

chat_end	db "You have a new companion... cherish this friend",0

flags: dw 0

line: dw 0
cols: dw 0

line_AI: dw 0
cols_AI: dw 0
