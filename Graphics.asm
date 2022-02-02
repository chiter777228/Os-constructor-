
%macro ClearDisplay 1
	mov al,%1
	mov ah,00h
	int 10h
%endmacro
;ax x ;cx y
%macro DrawPicture 0
	mov [Temp1],eax
	mov [Temp2],ebx
	mov [Temp3],cx
	mov [Temp5],dx
	lodsb
	mov ah,0
	add ax,cx
	mov [Temp4],ax
	lodsb
	mov ah,0
	mov bx,ax
	add bx,dx
;	mov edi,0
.%%DrawTexturePosX
    lodsb
	mov ah,0cH
	int 10h
	inc cx
	;inc edi
	;cmp edi,16384
	;jz %%end1
	;jnz %%end
;%%Da:
	;add edi,[Temp1]
	;mov esi,edi
	;mov edi,0
	;cld
;%%end:
	mov ax,[Temp4]
	cmp cx,ax
	jz .%%DrawTexturePosY
	jnz .%%DrawTexturePosX
.%%DrawTexturePosY
	mov cx,[Temp3]
	mov dx,[Temp5]
	inc dx
	;inc edi
	mov [Temp5],dx
	cmp dx,bx
	jz .%%end1
	jnz .%%DrawTexturePosX
.%%end1
	mov eax,[Temp1]
	mov ebx,[Temp2]
%endmacro

%macro DrawText 1
	mov al,%1
	cmp al,1
	mov ah,0x0e
	jz %%DrawTextLOOP
	mov ah,0x0e
    mov al,10
	int 10h
	mov al,13
	int 10h
	mov ah,0x0e
%%Draw_cube_loop_x:

%%DrawTextLOOP1:
	lodsb
	cmp al, 0
	jz %%end1
	int 10h
	jmp %%DrawTextLOOP1
%%DrawTextLOOP:
	lodsb
	cmp al, 0
	jz %%end
	int 10h
	jmp %%DrawTextLOOP
%%end1:
	mov ah,0x0e
    mov al,10
	int 10h
	mov al,13
	int 10h
	mov al,'>'
	int 10h
	pop eax
%%end:
%endmacro

%macro DrawCube 5
	push cx
	push dx
	push bx
	push ax
	mov cl,%1
	mov dl,%2
	mov bl,%3
	mov bh,%4
	mov al,%5
	mov ch,0
	mov [Temp],cl
	mov dh,0
%%Draw_cube_loop_x: 
	mov ch,0
	mov dh,0
	mov ah,0cH
	int 10h
	cmp bl,cl
	jz %%Draw_cube_loop_y
	inc cl
	jmp %%Draw_cube_loop_x
%%Draw_cube_loop_y:
	mov cl,[Temp]
	cmp dl,bh
	jz %%end
	inc dl
	JMP %%Draw_cube_loop_x
%%end:
	pop cx
	pop dx
	pop bx
	pop ax
%endmacro
