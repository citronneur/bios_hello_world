;disk.asm - disk function thought BIOS


;reset - void reset(void)
;reset disk position
disk_reset:
	mov ax, 0
	int 13h
