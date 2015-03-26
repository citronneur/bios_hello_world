NASM 		= nasm
QEMU 		= qemu-system-i386
QEMU_DRIVE 	= a

NAME 		= hash_x86
FILENAME 	= $(NAME).img

IMAGE 		= build/$(FILENAME)
ISO_IMAGE 	= build/iso/$(FILENAME)
ISO 		= build/$(NAME).iso
ISO_DIR 	= build/iso

BOOT 		= src/boot.asm
SRC		=	src/io.asm\
			src/disk.asm

all: $(IMAGE)

$(IMAGE): $(BOOT) $(SRC)
	$(NASM) -isrc/ -f bin -o $(IMAGE) $(BOOT)

qemu:
	$(QEMU) $(QEMU_SPEAKER) -boot $(QEMU_DRIVE) -fd$(QEMU_DRIVE) $(IMAGE)

clean:
	rm $(IMAGE)

.PHONY: qemu clean
