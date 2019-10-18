assume cs:codesg, ds:datasg

datasg segment
db	'ibm             '
db	'dec			 '
db	'dos			 '
db	'vax			 '
dw	0					; 定义一个字, 用来保存cx
datasg ends

codesg	segment
start:	mov	ax, datasg
		mov ds,	ax
		mov bx,	0		; 用BX来定位行
		
		mov	cx,	4
	s0:	mov ds:[40H], cx	; 将外层循环的cx值保存在datasg:40H单元中
		mov	si,	0		; 用si来定位列
		mov	cx,	3		; cx设置为内层循环的次数
	s:	mov	al,	[bx+si]
		and	al,	11011111b
		mov	[bx+si], al
		
		inc si
		
		loop s		    ; 此时的 cx 已经为0
		
		add	bx, 16
		mov cx, ds:[40H] 		; 从进行外层循环的时候, 恢复外层循环的值
		loop s0			; cx = cx -1 , 再判断 cx 为是否为0
		
		mov ax, 4c00h
		int 21h
	
end codesg
end start