times 510 - ($ - $$) db 0	; pad to 510 bytes
dw 0xAA55	; pad 2 more bytes = 512 bytes = THE BOOT SECTOR
_start:
	jmp $ ; loop forever
