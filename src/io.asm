;io.asm - Console like print function

;print - print a string terminated by zero
;void print(char* s)
print:
	push bp
	mov bp, sp
	push si
	push ax
	push bx

	mov si, [bp + 4]
.loop:
	lodsb

	cmp al, 0
	je .end

	mov ah, 0eh
	mov bx, 0
	int 10h
	
	jmp .loop
.end:
	pop bx
	pop ax
	pop si

	mov sp, bp
	pop bp
	ret

;println - print string and apply line return at the end
;void println(char* s)
println:
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	
	mov ax, [bp + 4]
	push ax
	call print

	;read cursor postion
	mov ah, 03h
	mov bh, 0
	int 10h

	;dh row number
	;dl column number
	
	;next line
	inc dh
	;carriage return
	mov dl, 0
	
	mov ah, 02h
	mov bh, 0
	int 10h	
	
	pop dx
	pop cx
	pop bx
	pop ax	
	mov sp, bp
	pop bp
	ret
