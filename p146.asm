assume cs:codesg, ds:datasg, ss:stacksg

stacksg	segment
	dw 0,0,0,0,0,0,0,0
stacksg ends

datasg	segment
	db	'1. diasplay.....'
	db	'2. brows........'
	db	'3.	replace......'
	db	'4.	modify.......'
datasg ends

codesg	segment
start:	mov	ax, stacksg
		mov ss,	ax
		mov sp, 16
		mov ax, datasg
		mov ds, ax
		mov bx, 0
		
		mov cx, 4
	s0:	push cx
		mov si, 0
		mov cx, 4
	s:	mov al, [bx+si+3]
		and al, 11011111b
		mov [bx+si+3], al
		inc si
		loop s
		add	bx,	16
		pop cx
		loop s0
		
		mov ax, 4c00h
		int 21h
datasg ends
end start