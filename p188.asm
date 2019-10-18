assume cs:code, ds:data, ss:stack


data segment

		db	'welcome to masm!'	;定义要显示的字符串(共16字节)
		db	02h,24h,71h			;定义三种颜色属性
		
data ends


stack segment

		dw 8 dup(0)
		
stack ends


code segment

start:
		mov ax,data
		mov ds,ax
		mov ax,stack
		mov ss,ax
		mov sp,10h
		
		xor bx,bx				;bx清零,用来索引颜色
		mov ax,0b872h			;算出屏幕第12行中间的显存的段起始位置放入ax中
		
		mov cx,3				;s3循环控制行数,外循环为3次,因为要显示三个字符串
s3:		push cx					;三个进栈操作为外循环s3保存相关寄存器的值
		push ax					;以防止它们的值在内循环中被破坏
		push bx
		
		mov es,ax				;此时es为屏幕第12行中间的显存的段起始位置
		
		mov si,0				;si用来索引代码列的字符
		mov di,0				;di用来定位目标列
		
		mov cx,10h
		;S1循环控制存放的字符,内循环为10h次,因为一个字符串中含10h个字节
s1:		mov al,ds:[si]
		mov	es:[di],al
		inc si
		add di,2
		loop s1
		
		mov di,1
		pop bx
		mov al,ds:10h[bx]
		inc bx
		
		mov cx,10h				;第二个内循环也为10h次
s2:		mov es:[di],al
		add	di,2
		loop s2					;此循环实现奇地址中存放字符的颜色属性
		
		;以下4句为下一趟外循环做准备
		pop ax
		add ax,0ah				;将显存的2起始段地址设为当前行的下一行
								;[在段地址中加0ah,相当于在偏移地址中加了0a0h(=160d)]
		pop cx
		loop s3
		
		
		mov ax,4c00h
		int 21h
code ends
end start
							