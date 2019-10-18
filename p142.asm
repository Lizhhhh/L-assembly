assume cs:codesg, ds:datasg

datasg segment
db	'ibm             '
db	'dec			 '
db	'dos			 '
db	'vax			 '
datasg ends

codesg	segment
start:	mov	ax, datasg
		mov ds,	ax
		mov bx,	0		; 用BX来定位行
		
		mov	cx,	4
	s0:	mov	si,	0		; 用si来定位列
		mov	cx,	3
	s:	mov	al,	[bx+si]
		and	al,	11011111b
		mov	[bx+si], al
		
		inc si
		
		loop s		    ; 此时的 cx 已经为0
		
		add	bx, 16
		loop s0			; cx = cx -1 , 再判断 cx 为是否为0
		
		mov ax, 4c00h
		int 21h
	
end codesg
end start