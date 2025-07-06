[BITS 16]
[GLOBAL guess_num]
extern sys_read
extern sys_write
extern clear_src
guess_num:
	xor ax, ax
	mov ds, ax
	mov es, ax
; CLEAR MEM
	mov di, ip_choose
	mov [di], ax

	call clear_src
	mov si, gn_1
	call sys_write

	mov si, ip_choose
	call sys_read

	mov al, [ip_choose]

	cmp al, 'p'
	je play_guess_game

	cmp al, 'q'
	je back_to_menu_game

	mov ax, [ip_choose]

	cmp ax, 'GI'
	je game_intruction

	jmp guess_num


play_guess_game:
	call clear_src

	mov di, ip_choose
	mov word [ip_choose], 0x00
; GET RANDOM

	rdtsc
	mov ax, dx

	mov cx, 100
	xor dx, dx
	div cx

	mov [save_num], dx
guess:

	mov si, ip_player_1
	call sys_write

	mov si, ip_player
	call sys_read

	mov al, [ip_player]
	cmp al, 'q'
	je back_to_menu_game

	mov ax, [ip_player]

	cmp ax, 0x322F
	je div_2

	cmp ax, 0x332F
	je div_3

	cmp ax, 0x342F
	je div_4

	cmp ax, 0x352F
	je div_5

	cmp ax, 0x362F
	je div_6

	cmp ax, 0x372F
	je div_7

	cmp ax, 0x382F
	je div_8

	cmp ax, 0x392F
	je div_9

	cmp ax, 0x646F
	je check_odd

	cmp ax, 0x6E65
	je check_even

	cmp ax, 0x6570
	je check_prime

	cmp ax, 0x7761
	je answer_num

	mov si, newline
	call sys_write

	jmp guess

div_2:
	xor dx, dx
	xor cx, cx
	xor ax, ax

	mov di, save_num
	mov ax, [di]
	mov cx, 2
	div cx

	test dx, dx

	je True
	jne False

div_3:
        xor dx, dx
        xor cx, cx
        xor ax, ax

	mov di, save_num
        mov ax, [di]
        mov cx, 3
        div cx

	test dx, dx
	je True
	jne False


div_4:
        xor dx, dx
        xor cx, cx
        xor ax, ax

	mov di, save_num
        mov ax, [di]
        mov cx, 4
        div cx

	test dx, dx
	je True
	jne False

div_5:
        xor dx, dx
        xor cx, cx
        xor ax, ax

	mov di, save_num
        mov ax, [di]
        mov cx, 5
        div cx

        test dx, dx
        je True
        jne False

div_6:
        xor dx, dx
        xor cx, cx
        xor ax, ax

	mov di, save_num
        mov ax, [di]
        mov cx, 6
        div cx

        test dx, dx
        je True
        jne False


div_7:
        xor dx, dx
        xor cx, cx
        xor ax, ax

	mov di, save_num
        mov ax, [di]
        mov cx, 7
        div cx

        test dx, dx
        je True
        jne False


div_8:
        xor dx, dx
        xor cx, cx
        xor ax, ax

	mov di, save_num
        mov ax, [di]
        mov cx, 8
        div cx

        test dx, dx
        je True
        jne False

div_9:
        xor dx, dx
        xor cx, cx
        xor ax, ax

	mov di, save_num
        mov ax, [di]
        mov cx, 9
        div cx

        test dx, dx
        je True
        jne False

check_even:
	xor ax, ax

	mov di, save_num
	mov ax, [di]
	test ax, 1
	je True
	jne False

check_odd:

	xor ax, ax
	mov di, save_num
	mov ax, [di]

	test ax, 1

	jnz True
	jz False

check_prime:
        xor ax, ax

	xor bx, bx
        xor cx, cx

        or cx, 1

loop_check:
	xor dx, dx

	mov di, save_num
        mov ax, [di]
	div cx

	test dx, dx
	jne skip_check

	inc bx				; bx = count
skip_check:
	inc cx
	mov ax, [save_num]

	cmp ax, cx
	jle loop_check

	cmp bx, 2
	je True
	jne False





True:
	xor ax, ax
	mov si, newline
	call sys_write

	mov si, msg_true
	call sys_write

	mov di, ip_player
	mov word [di], ax

	jmp guess

False:
	xor ax, ax
	mov si, newline
	call sys_write

	mov si, msg_false
	call sys_write

        mov di, ip_player
        mov word [di], ax

	jmp guess

answer_num:
	mov si, newline
	call sys_write

	mov si, an_num_msg
	call sys_write

	mov si, num_an
	call sys_read

	mov si, num_an
	mov al, [si]

	cmp al, 'q'
	je guess_1

	mov si, num_an
	call str_to_int
	mov bx, ax

	mov cx, [save_num]

	cmp bx, cx
	je win

	jne wrong

guess_1:
	mov si, newline
	call sys_write

	jmp guess
win:
	mov si, newline
	call sys_write

	mov si, win_msg
	call sys_write

	mov si, newline
	call sys_write

	jmp con
wrong:
	mov si, newline
	call sys_write

	mov si, wrong_msg
	call sys_write

	mov si, newline
	call sys_write

	jmp answer_num







con:
	mov si, con_1
	call sys_write

	mov si, ip
	call sys_read

	mov si, ip
	mov al, [si]
	cmp al, 'c'
	je guess_num

	cmp al, 'q'
	je back_to_menu_game

	mov si, newline
	call sys_write

	jmp con










game_intruction:
	call clear_src

	mov si, gi_guess_num
	call sys_write

	xor ah, ah
	int 0x16

	cmp al, 'q'
	je guess_num

	jmp game_intruction





back_to_menu_game:
	call clear_src
	ret


;-------------------















;-------------------------------------------------------------
str_to_int:
	xor ax, ax
	xor cx, cx
loop:
	movzx cx, byte [si]

	cmp cx, 10
	je done

	cmp cx, 0x0
	je done

	sub cx, '0'
	imul ax, ax, 10
	add ax, cx
	inc si
	jmp loop

done:
	ret












;------------------------------------------------
; SECTION .DATA
ip_player_1  db "Enter your string to guess the number : ", 0

con_1        db "If you want to continue playing type 'c'| to exit type 'q' : ",0

gn_1         db "                         Welcome to guess num                         ", 13,10
	     db "Please enter 'p' to start game or enter GI to get game instructions : ", 0

an_num_msg    db "Enter number you guess : ", 0

gn_2 	      db "Press enter to start game",0

gi_guess_num  db "                        Game instructions", 13, 10
              db "==============================================================", 13, 10
              db "+                       Guess the Number                     +", 13, 10
              db "==============================================================", 13, 10
              db "               I have picked a number from 0 to 99.", 13, 10
              db "        Try to guess it, or use commands to help!", 13, 10
              db "", 13, 10
              db "Commands", 13, 10
              db "  /2     --> Is the number divisible by 2?", 13, 10
              db "  /3     --> Is the number divisible by 3?", 13, 10
              db "  /4     --> Is the number divisible by 4?", 13, 10
              db "  /5     --> Is the number divisible by 5?", 13, 10
              db "  /6     --> Is the number divisible by 6?", 13, 10
              db "  /7     --> Is the number divisible by 7?", 13, 10
              db "  /8     --> Is the number divisible by 8?", 13, 10
              db "  /9     --> Is the number divisible by 9?", 13, 10
              db "  pe     --> Is the prime number", 13, 10
              db "  en     --> Is it even?", 13, 10
              db "  od     --> Is it odd?", 13, 10
              db "  aw     --> Answer the number you guess", 13, 10
              db "  q      --> Quit game instructions", 13, 10, 0

msg_true      db "TRUE",13,10,0
msg_false      db "FALSE",13,10,0

win_msg		db "You win",13,10,0
wrong_msg 	db "Wrong number , try again",13,10,0

newline db 13,10,0

ip_choose: times 2 db 0

ip_player: times 3 db 0

save_num:  times 1 dw 0

num_an:    times 3 db 0

ip:        times 1 db 0
