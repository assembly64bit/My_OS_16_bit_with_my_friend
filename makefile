# 👑 GRP OS - Makefile
# Tự động build bootloader, kernel từ nhiều file .asm

all: os.img

# 🧱 Build bootloader (stage 1 - 512 byte)
bootloader.bin: bootloader.asm
	nasm -f bin bootloader.asm -o bootloader.bin

# 🧠 Build kernel từ nhiều file .asm
kernel.elf: kernel.asm sys_write.asm sys_read.asm sys_read_special.asm sys_draw.asm scroll_up.asm scroll_down.asm clear_src.asm menu_calculator.asm basic.asm dec_to_bin.asm LCM_GCD.asm menu_game.asm guess_num.asm x_o.asm menu_game_2048.asm easy_mode.asm UI_sur.asm play.asm inventory.asm player_wp.asm player_cth.asm player_armor.asm ai_wp.asm ai_cth.asm ai_armor.asm menu_learn_app.asm linker.ld

	nasm -f elf32 kernel.asm -o kernel.o

	nasm -f elf32 sys_write.asm -o sys_write.o
	nasm -f elf32 sys_read.asm -o sys_read.o
	nasm -f elf32 clear_src.asm -o clear_src.o
	nasm -f elf32 sys_read_special.asm -o sys_read_special.o
	nasm -f elf32 sys_draw.asm -o sys_draw.o
	nasm -f elf32 scroll_up.asm -o scroll_up.o
	nasm -f elf32 scroll_down.asm -o scroll_down.o

	nasm -f elf32 menu_game.asm -o menu_game.o
	nasm -f elf32 guess_num.asm -o guess_num.o
	nasm -f elf32 x_o.asm -o x_o.o
	nasm -f elf32 menu_2048.asm -o menu_game_2048.o
	nasm -f elf32 easy_mode.asm -o easy_mode.o
	nasm -f elf32 UI_sur.asm -o UI_sur.o
	nasm -f elf32 play.asm -o play.o
	nasm -f elf32 inventory.asm -o inventory.o
	nasm -f elf32 player_wp.asm -o player_wp.o
	nasm -f elf32 player_cth.asm -o player_cth.o
	nasm -f elf32 player_armor.asm -o player_armor.o
	nasm -f elf32 ai_wp.asm -o ai_wp.o
	nasm -f elf32 ai_cth.asm -o ai_cth.o
	nasm -f elf32 ai_armor.asm -o ai_armor.o

	nasm -f elf32 menu_learn_app.asm -o menu_learn_app.o

	nasm -f elf32 menu_calculator.asm -o menu_calculator.o
	nasm -f elf32 basic.asm -o basic.o
	nasm -f elf32 dec_to_bin.asm -o dec_to_bin.o
	nasm -f elf32 LCM_GCD.asm -o LCM_GCD.o

	ld -m elf_i386 -T linker.ld -o kernel.elf kernel.o sys_write.o sys_read.o sys_read_special.o sys_draw.o scroll_up.o scroll_down.o clear_src.o menu_calculator.o basic.o dec_to_bin.o LCM_GCD.o menu_game.o guess_num.o x_o.o menu_game_2048.o easy_mode.o UI_sur.o play.o inventory.o player_wp.o player_cth.o player_armor.o ai_wp.o ai_cth.o ai_armor.o menu_learn_app.o

# ✂️ Cắt ELF thành raw binary (cho BIOS xài)
kernel.bin: kernel.elf
	dd if=kernel.elf of=kernel.bin bs=512 conv=notrunc



# 🖼️ Tạo đĩa image đầy đủ
os.img: bootloader.bin kernel.bin
	dd if=/dev/zero of=os.img bs=512 count=2880
	dd if=bootloader.bin of=os.img conv=notrunc bs=512 seek=0
	dd if=kernel.bin of=os.img conv=notrunc bs=512 seek=1

# 🚀 Chạy bằng QEMU
run: os.img
	qemu-system-i386 -drive if=floppy,format=raw,file=os.img

# 🐛 Debug bằng GDB
debug: os.img
	qemu-system-i386 -fda os.img -S -gdb tcp::1234

# 🧹 Dọn sạch
clean:
	rm -f *.bin *.o *.elf *.img

