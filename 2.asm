assume cs:codesg

codesg segment

fishcc: mov ax, 2000H
        mov ds, ax
		mov al,[0]
        mov bl,[1]
        mov cl,[2]
        mov dl,[3]

        mov ax, 4C00H
        int 21H

codesg ends

end fishcc