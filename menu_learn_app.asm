[BITS 16]
[GLOBAL menu_learn_app]

extern sys_write
extern clear_src
menu_learn_app:
	xor ax, ax
	mov ds, ax
	mov es, ax
menu:
	call clear_src
	mov si, menu_msg
	call sys_write
input:
	xor ax, ax
	int 0x16

	cmp al, '1'
	je menu_lesson_1

	cmp al, '2'
	je menu_lesson_2

	cmp al, '3'
	je menu_lesson_3

	cmp al, '4'
	je menu_test

	cmp al, '5'
	je back_to_menu

	jmp input

menu_lesson_1:
menu_lesson_2:
menu_lesson_3:
menu_test:

























back_to_menu:
	call clear_src
	ret






















; SECTION .DATA
menu_msg db "*******************************************************************************",13,10
         db "*                                Welcome to learn app for asm 64              *",13,10
         db "*******************************************************************************",13,10
         db "*                                1. Lesson 1                                  *",13,10
         db "*                                2. Lesson 2                                  *",13,10
         db "*                                3. Lesson 3                                  *",13,10
         db "*                                4. Test                                      *",13,10
         db "*                                5. Back_to_menu                              *",13,10
         db "*******************************************************************************",13,10
	 db "Enter numbers from 1-->4 to learn : ",0
