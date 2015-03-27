;disk.asm - disk function thought BIOS

;message
disk_reset_info: db 'Reset drive...', 0
disk_reset_error: db 'Error during drive reset', 0
disk_load_info: db 'Load from drive...', 0
disk_load_error: db 'Error during read drive', 0

;reset - void reset(byte drive_number)
;reset current drive position
drive_reset:
	push bp
	push ax
	push dx
	mov bp, sp

	push disk_reset_info
	call io_println
	
	mov dx, [bp + 8]
	mov ah, 0
	int 13h

	jnc .end
	
	push disk_reset_error
	call io_println
.end:
	mov sp, bp
	pop dx
	pop ax
	pop bp
	ret

;drive_load - load nb sector after first from drive number to destination es:0x200
;void drive_load( drive_num, byte nb_sector)
drive_load:
	push bp
	push ax
	push bx
	push cx
	push dx
	mov bp, sp

	push disk_load_info
	call io_println
	
	mov dh, 0 ;head number
	mov dl, [bp + 12] ;drive number

	mov ah, 02h ;read sector function code
	mov al, [bp + 13] ;nb sectors

	mov ch, 0
	mov cl, 2

	mov bx, 0x200
	
	int 13h
	jnc .end

	push disk_load_error
	call io_println
	
.end:
	mov sp,bp
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret
