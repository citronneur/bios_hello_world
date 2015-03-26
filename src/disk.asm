;disk.asm - disk function thought BIOS

;message
disk_reset_info: db 'Reset disk ...', 0
disk_reset_error: db 'Error during disk reset', 0

;reset - void reset(void)
;reset disk position
;dl	IN	disk selector
;cy	OUT	set if error
disk_reset:
	push bp
	mov bp, sp
	push ax

	push disk_reset_info
	call println
	
	mov ah, 0
	int 13h

	jnc .end
	
	cmp ah, 0
	jne .end

	push disk_reset_error
	call println
.end:
	pop ax
	mov sp, bp
	pop bp
	
	ret
