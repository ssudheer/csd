; Computer System Design Lab, Assignment-1
; Inverse of the Matrix

; Declaring externel Functions
extern printf

SECTION .data
	msg: db "Hello World",10
	len: equ $-msg
SECTION .text

global main

main:
	mov edx,len ; arg3 for length of the string
	mov ecx,msg ; arg2 pointer to string
	mov ebx,1   ; arg1where to write , 1 for screen
	mov eax,4	; write sysout command to int 80 hex
	int 0x80    ; interrput call kernel
	
; exit(0)
mov eax,0
ret
