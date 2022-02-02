section .text
use16
org 0x7c00
%include 'Graphics.asm' 
start:
section .data

mov ax,3
int 10h

k db 'da'

mov ah,0x0E
mov al,[k]
int 10h

jmp $


