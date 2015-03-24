bits 16 ; BIOS only accept 16 bits mode
org 0
	jmp 07C0h:start

start:
	mov ax, cs
	mov ds, ax
	mov es, ax
	cli
	sti
	mov ah, 0eh
	mov al, 'b'
	int 0x10

times 510 - ($ - $$) db 0 ; fill 512 bytes with zero	
dw 0xAA55 ; boot signature
