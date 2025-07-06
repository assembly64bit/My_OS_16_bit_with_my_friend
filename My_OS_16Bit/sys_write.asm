[BITS 16]
[GLOBAL sys_write]

sys_write:
	lodsb
	test al, al
	je done_sys_write

	mov ah, 0x0E
	int 0x10

	jmp sys_write

done_sys_write:
	ret
