;io.asm - Console like print function

;io_print - io_print a string terminated by zero
;void print(char* s)
io_print:
	push bp
	push ax
	push bx
	mov bp, sp

	mov si, [bp + 8]
.loop:
	lodsb

	cmp al, 0
	je .end

	mov ah, 0eh
	mov bx, 0
	int 10h
	
	jmp .loop
.end:
	mov sp, bp
	pop bx
	pop ax
	pop bp
	ret

;io_new_line - set cursor to a new line
;void io_new_line(void)
io_new_line:
	push bp
	push ax
	push bx
	push dx
	mov bp, sp
	
	;read cursor postion
	mov ah, 03h
	mov bx, 0
	int 10h

	;dh row number
	;dl column number
	
	;next line
	inc dh
	;carriage return
	mov dl, 0
	
	mov ah, 02h
	mov bx, 0
	int 10h	
	
	mov sp, bp
	pop dx
	pop bx
	pop ax
	pop bp
	ret

;io_println - print string follow by a new line
;void io_println(char* s);
io_println:
	push bp
	push ax
	mov bp, sp
	
	mov ax, [bp + 6]
	push ax
	call io_print
	call io_new_line

	mov sp, bp
	pop ax
	pop bp
	ret
