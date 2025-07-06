
render_frame:
        mov ax, 0xB800
        mov es, ax

        mov cx, 25            ; tổng cộng 25 dòng
        xor si, si            ; si = index dòng hiện tại

.next_row:
        ; Tính offset VRAM: (si * 160)
        mov ax, si
        mov bx, 160
        mul bx
        mov di, ax            ; di = offset dòng trong VRAM

    ; === Player Block ===
        mov bx, si
        mov bp, inventory_player
        imul bx, 39
        add bp, bx
        call write_block_39

    ; === Center Msg Block ===
        mov bp, msg
        imul bx, 2
        add bp, bx
        call write_block_2

    ; === AI Block ===
        mov bp, inventory_AI
        imul bx, 39
        add bp, bx
        call write_block_39

        inc si
        loop .next_row
        ret










; Viết 39 ký tự từ [bp] → [es:di]
write_block_39:
        mov dx, 39
.w_loop:
        mov al, [bp]
        mov [es:di], al
        mov byte [es:di+1], 0x07
        inc bp
        add di, 2
        dec dx
        jnz .w_loop
        ret

; Viết 2 ký tự (thanh giữa) từ [bp] → [es:di]
write_block_2:
        mov dx, 2
.w_loop2:
        mov al, [bp]
        mov [es:di], al
        mov byte [es:di+1], 0x88
        mov ah, 0x07
        inc bp
        add di, 2
        dec dx
        jnz .w_loop2
        ret
