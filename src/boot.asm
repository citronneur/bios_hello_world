%define SEGMENT_SIZE 16
%define SECTOR_SIZE 512
%define SECTORS	2
%define STACK_SIZE 4096
bits 16 ; BIOS only accept 16 bits mode
org 0
	jmp 07C0h:start

%include 'disk.asm'
start:
	mov ax, cs
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	; compute the stack segment
	; start at the end of all sector + stack size
	mov ax, (SECTORS * SECTOR_SIZE + STACK_SIZE) / SEGMENT_SIZE
	mov ss, ax

	call disk_reset

times 510 - ($ - $$) db 0 ; fill 512 bytes with zero	
dw 0xAA55 ; boot signature
times (SECTORS * SECTOR_SIZE) - ($ - $$) db 0 ; fill rest of image with zero
