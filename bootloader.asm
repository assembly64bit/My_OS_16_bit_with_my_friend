[BITS 16]
[ORG 0x7C00]
start:
        cli
        xor ax, ax
        mov ds, ax
        mov es, ax

; CLEAR_SRCEEN
        mov ah, 0x06       ; Scroll up function
        mov al, 0           ; Number of lines to scroll up (0 = clear entire window)
        mov bh, 0x07        ; Attribute used for blank lines (white on black)
        mov cx, 0x0000      ; Upper left corner of window (row=0, col=0)
        mov dx, 0x184F      ; Lower right corner (row=24, col=79)
        int 0x10            ; Call BIOS video service

        mov ah, 02h    ; Hàm set cursor position
        mov bh, 0      ; Số trang (thường là 0)
        mov dh, 0      ; Hàng (row) = 0 (trên cùng)
        mov dl, 0      ; Cột (column) = 0 (trái cùng)
        int 10h        ; Gọi BIOS video service

; LOOP_PRINT

	mov si, msg
print:
	lodsb

	test al, al
	jz load

	mov ah, 0x0E
	int 0x10

	jmp print
load:
; WAIT 3 SEC

	mov ah, 86h
	mov cx, 0
	mov dx, 3000
	int 15h

; LOAD
	xor cx, cx
	xor ah, ah
	xor dx, dx

	mov bx, 0x8000
	mov dh, 0

	mov dl, 0
	mov ch, 0

	mov cl, 2
	mov ah, 0x02
	mov al, 50
	int 0x13
	jc error
	jmp 0x0800:0000

error:
	cli
	hlt


msg db "Loading kernel ...", 0

times 510 - ( $ - $$ ) db 0
dw 0xAA55
