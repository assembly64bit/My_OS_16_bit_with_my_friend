[BITS 16]
[GLOBAL menu_calculator]

extern sys_write
extern sys_read
extern clear_src

extern basic_calculations
extern dec_to_bin
extern LCM_GCD
menu_calculator:
	xor ax, ax
	mov ds, ax
	mov es, ax
calculator_1:
	call clear_src

	mov si, menu_msg
	call sys_write
loop:
	xor ax, ax
	int 0x16

	cmp al, '1'
	je c_1

	cmp al, '2'
	je c_2

	cmp al, '3'
	je c_3

	cmp al, '4'
	je Back_to_menu

	jmp loop

c_1:
	call clear_src
	call basic_calculations
	jmp menu_calculator
c_2:
	call clear_src
	call dec_to_bin
	jmp menu_calculator
c_3:
	call clear_src
	call LCM_GCD
	jmp menu_calculator

Back_to_menu:
	call clear_src
	ret

































menu_msg db "*******************************************************************************",13,10
         db "*                                Welcome to calculator                        *",13,10
         db "*******************************************************************************",13,10
         db "*                                1. Basic calculations                        *",13,10
         db "*                                2. Dec to bin                                *",13,10
         db "*                                3. GCD and LCM                               *",13,10
         db "*                                4. Back to menu                              *",13,10
         db "*******************************************************************************",13,10
         db "Enter numbers from 1-->3 to activate : ",0

