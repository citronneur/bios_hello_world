%define SEGMENT_SIZE 16
%define SECTOR_SIZE 32 ; in segment (true size * 16)
%define SECTORS	2
%define STACK_SIZE 256 ; in segment (true size * 16)

bits 16 ; BIOS only accept 16 bits mode
org 0
	jmp 07C0h:load

%include 'io.asm'
%include 'drive.asm'

boot_start_message: db 'Booting Tetris...', 0

load:
	;init all segment with first sector
	mov ax, cs
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	; compute the stack segment
	; start at the end of all sector + stack size
	add ax, (SECTORS * SECTOR_SIZE) + STACK_SIZE
	mov ss, ax
	mov sp, STACK_SIZE * SEGMENT_SIZE
	
	push boot_start_message
	call io_println
	
	;dl contain the actual drive number
	push dx
	call drive_reset

	mov ah, SECTORS
	mov al, dl
	push ax
	call drive_load

times 510 - ($ - $$) db 0 ; fill 512 bytes with zero	
dw 0xAA55 ; boot signature
start:
	push boot_start_message
	call io_println
times (SECTORS * SECTOR_SIZE * SEGMENT_SIZE) - ($ - $$) db 0 ; fill rest of image with zero
