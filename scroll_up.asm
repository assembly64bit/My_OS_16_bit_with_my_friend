[BITS 16]
[GLOBAL scroll_up]
scroll_up:
	mov ah, 06h
	mov al, 04h		; cuộn 4 dòng
	mov bh, 00h
	mov cx, 0
	mov dx, 184Fh
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 4		; dòng row , tùy vào số dòng cuộn
	mov dl, 0
	int 10h
	ret
