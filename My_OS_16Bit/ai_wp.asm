[BITS 16]
[GLOBAL wepon_AI]

extern sys_write
extern clear_src
extern sys_read

wepon_AI:
        call clear_src

        mov si, w_1
        call sys_write

        mov si, wepon_melee
        call sys_write
;--------------------------------------------
        mov si, w_2
        call sys_write

        mov si, handgun
        call sys_write
;--------------------------------------------
        mov si, w_3
        call sys_write

        mov si, rifle
        call sys_write
;-----------------------------------------
        xor ax, ax
        int 0x16

        cmp al, 'q'
        je back
;----------------------------------------
back:
        call clear_src
        ret
















w_1                     db " Wepon_Melee : ",0
w_2                     db " Hand_Gun    : ",0
w_3                     db " Rifle       : ",0

wepon_melee             db  'B', 'A', 'S', 'E', 'B', 'A', 'L', 'L',0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,10,13,0

handgun                 db 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,10,13,0

rifle                   db 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,10,13,0
