assume cs:codesg

codesg	segment
	
	start:	mov ax,0
			jmp short segment
			add	ax,1
			add	ax,ax
		s:	inc ax

codesg ends
end start
		