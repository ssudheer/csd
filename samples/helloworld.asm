; helloworld.asm program
; Sudheer Sana
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
	
	
	; exit code
	mov ebx,0    ; exit code 0=normal
	mov eax,1    ; exit command to kernel
	int 0x80	 ; interrupt 80 hex kernel
