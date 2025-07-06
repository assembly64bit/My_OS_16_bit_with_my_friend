[BITS 16]
[GLOBAL scroll_down]

scroll_down:
	mov ah, 07h
	mov al, 04h
	mov bh, 00h
	mov cx, 0
	mov dx, 184Fh
	int 10h

        mov ah, 02h
        mov bh, 0
        mov dh, 4               ; dòng row , tùy vào số dòng cuộn
        mov dl, 0
        int 10h
        ret
