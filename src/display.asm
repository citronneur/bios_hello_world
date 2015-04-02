;display.asm - display functions

;display_aenable - set video mode to 320x200 @ 256 color mode
;void display_mode(void)
display_enable:
	push bp
	push ax
	mov bp, sp

	mov ah, 0h
	mov al, 13h ;320x200 @ 256 color mode

	int 10h

	mov sp, bp
	pop ax
	pop bp
	ret
