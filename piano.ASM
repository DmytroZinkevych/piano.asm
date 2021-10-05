title	music
sseg	segment stack
	db	256 dup(?)
sseg	ends
dseg	segment

intro	db	"Welcome to piano program! Press q, w, e, r, t, y, u, i to play or 0 to exit $"

dseg	ends
cseg	segment
	assume	ss:sseg,cs:cseg,ds:dseg
start:	jmp main		 ; 5b8d8   ;3d090

play:	mov	cx,03h		; старше слово числа мікросекунд паузи
	mov	dx,0d40h       ; молодше слово числа мікросекунд паузи
	mov	ah,86h		; функція 86h
	int	15h		; пауза
;	 mov	 cx, 0h
 ;	 mov	 dx, 0h

	mov	al,0h	       ; молодший байт дільника частоти
	out	42h,al
	mov	al,0h	       ; старший байт дільника частоти
	out	42h,al

	mov	cx,0h	       ; старше слово числа мікросекунд паузи
	mov	dx,0h	    ; молодше слово числа мікросекунд паузи
	mov	ah,86h		; функція 86h
	int	15h		; пауза
	ret

do:	mov	al,0dbh 	 ; молодший байт дільника частоти
	out	42h,al
	mov	al,11h		; старший байт дільника частоти
	out	42h,al
	call	play
	ret

re:	mov	al,0dfh 	 ; молодший байт дільника частоти
	out	42h,al
	mov	al,0fh		; старший байт дільника частоти
	out	42h,al
	call	play
	ret

mi:	mov	al,024h 	 ; молодший байт дільника частоти
	out	42h,al
	mov	al,0eh		; старший байт дільника частоти
	out	42h,al
	call	play
	ret

fa:	mov	al,058h 	 ; молодший байт дільника частоти
	out	42h,al
	mov	al,0dh		; старший байт дільника частоти
	out	42h,al
	call	play
	ret

sol:	mov	al,0e3h 	 ; молодший байт дільника частоти
	out	42h,al
	mov	al,0bh		; старший байт дільника частоти
	out	42h,al
	call	play
	ret

la:	mov	al,097h 	 ; молодший байт дільника частоти
	out	42h,al
	mov	al,0ah		; старший байт дільника частоти
	out	42h,al
	call	play
	ret

si0:	mov	al,06fh 	 ; молодший байт дільника частоти
	out	42h,al
	mov	al,09h		; старший байт дільника частоти
	out	42h,al
	call	play
	ret

do1:	mov	al,0e8h 	 ; молодший байт дільника частоти
	out	42h,al
	mov	al,08h		; старший байт дільника частоти
	out	42h,al
	call	play
	ret

main:	push	ds
	xor	ax,ax
	push	ax
	mov	ax,dseg
	mov	ds,ax

	mov	dx, offset intro
	mov	ah, 9h
	int	21h

	mov	al,10110110b	; канал 2, режим 3
	out	43h,al
	in	al,61h		; поточний стан порту 61h у al
	or	al,00000011b	; встановити біти 0 і 1 в 1
	out	61h,al		; тепер динамік включений
;--------------------------------------------------

c:	mov	ah, 8h
	int	21h

	cmp	al, 'q'
	je	c1

	cmp	al, 'w'
	je	c2

	cmp	al, 'e'
	je	c3

	cmp	al, 'r'
	je	c4

	cmp	al, 't'
	je	c5

	cmp	al, 'y'
	je	c6

	cmp	al, 'u'
	je	c7

	cmp	al, 'i'
	je	c8

	cmp	al, '0'
	je	exit

	jmp	c

c1:	call	do
	jmp	c

c2:	call	re
	jmp	c

c3:	call	mi
	jmp	c

c4:	call	fa
	jmp	c

c5:	call	sol
	jmp	c

c6:	call	la
	jmp	c

c7:	call	si0
	jmp	c

c8:	call	do1
	jmp	c
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
exit:	in	al,61h
	and	al,11111100b	; покласти нулі на молодші два біти
	out	61h, al 	; тепер динамік виключений

	mov	ax,4c00h	; вихід з програми
	int	21h

cseg	ends
	end    start