[BITS 16]
[GLOBAL menu_lesson_1]

extern sys_write
extern sys_clear_src
extern lesson_1_1
menu_lesson_1:
	xor ax, ax
	mov es, ax
	mov ds, ax

	call clear_src
	mov si, menu_msg
	call sys_write
ip:
	xor ax, ax
	int 0x16

	cmp al,'1'
	je lesson_1_1
	jmp ip
lesson_1_1:
	call lesson_1_1
	jmp menu_lesson















































; SECTION .DATA

menu_msg	db "*******************************************************************************",13,10
 	        db "*                                Welcome to lesson 1                          *",13,10
 	        db "*******************************************************************************",13,10
 	        db "*                                1. What is a syscall                         *",13,10
 	        db "*                                2. Common syscalls: write, read , exit       *",13,10
 	        db "*                                3. Basic instructions: add, sub, imul, div   *",13,10
 	        db "*                                4. Practice exercises                        *",13,10
 	        db "*                                5. Back_to_menu                              *",13,10
 	        db "*******************************************************************************",13,10
		db "Enter num 1-->4 to choose lesson : ", 0
