AS      = nasm
CC      = gcc
LD      = ld

ASFLAGS = -f elf32
CFLAGS  = -m32 -ffreestanding -fno-stack-protector -nostdlib -nodefaultlibs -Wall -Wextra
LDFLAGS = -m elf_i386 -T linker.ld -nostdlib

BOOT_OBJ   = boot/boot.o
KERNEL_OBJ = kernel/kernel.o
KERNEL_BIN = kernel.bin
ISO        = os.iso
ISODIR     = isodir

all: $(ISO)

boot/boot.o: boot/boot.asm
	$(AS) $(ASFLAGS) $< -o $@

kernel/kernel.o: kernel/kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

$(KERNEL_BIN): $(BOOT_OBJ) $(KERNEL_OBJ)
	$(LD) $(LDFLAGS) $^ -o $@

$(ISO): $(KERNEL_BIN)
	mkdir -p $(ISODIR)/boot/grub
	cp $(KERNEL_BIN) $(ISODIR)/boot/kernel.bin
	printf 'set timeout=0\nset default=0\n\nmenuentry "Matthew'"'"'s OS" {\n    multiboot /boot/kernel.bin\n    boot\n}\n' \
		> $(ISODIR)/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO) $(ISODIR)

clean:
	rm -f $(BOOT_OBJ) $(KERNEL_OBJ) $(KERNEL_BIN)
	rm -rf $(ISODIR) $(ISO)

.PHONY: all clean
