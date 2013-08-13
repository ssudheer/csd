; Computer System Design Lab, Assignment-1
; Matrix Multiplication 

; Declaring externel Functions
extern printf

%macro printString 1

	SECTION	.data
	.str:	db	%1,0		; %1 is macro call first actual parameter
	;strlen: equ $-str
	SECTION .bss
	
	SECTION .text
push eax
push ebx
push ecx
push edx

	push	dword .str 	; users string
    push    dword strfmt       ; address of format string
    call    printf          ; Call C function
    add     esp,8          ; pop stack 8*4 bytes

pop edx
pop ecx
pop ebx
pop eax
%endmacro

; Macro for printing a number

%macro printNumber 1

	SECTION	.data
	;number:	db	%1,0		; %1 is macro call first actual parameter
	SECTION .bss
	
	SECTION .text
push ebx
push ecx
push edx
 
	push	dword [globalNum] 	; users string
    push    dword numfmt       ; address of format string
    call    printf          ; Call C function
    add     esp,8          ; pop stack 8*4 bytes

pop edx
pop ecx
pop ebx
%endmacro

printIntro:
	printString "Asssignment:1 Matrix Multiplication " 
ret
printRow:
	printString " Row number "
ret
printCol:
	printString " Col number "
ret
printThird:
	printString " Third "
callNum:
	push eax
	mov eax,[globalNum]
	
	mov [globalNum],eax
	printNumber eax
	pop eax
ret

rcToAddress:
		; get no of cols in ebx
	
		; if it is a first row then don't  care about of no of rows 
		; dec column and multiply with 4
		; if it is first row go to remRows
		; ecx contains row number
		; edx contains column number
		
		dec ecx
		dec edx
		imul ecx,4
		imul ecx,ebx
		imul edx,4
		add ecx,edx
		mov eax,ecx
	
ret
multiply:
	push ebx
		imul ecx,edx
		mov eax,ecx
		mov [globalNum],eax
		printNumber 
	pop ebx
	
ret	

SECTION .data ; declaring and intializing data, not for variables
	msg: db "Hello World",10
	len: equ $-msg
	msg1: db "ssudheer",10
	globalStr: db "sana",40
	len1: equ $-msg1
	a:	dd	5		; int a=5;
	
	;.str:	db	"sdfdfs",20		; %1 is macro call first actual parameter
	fmt:    db "a=%d, eax=%d", 10, 0 ; The printf format, "\n",'0'

	strfmt: db " %s ",10,0	; format string for printf
	numfmt: db " %d ",10,0
	globalNum: dd 0
	i: dd 1
	j: dd 1
	k: dd 1
	; size of matrix 2 x 2
	matrixA: dd 1,2,3,4
	ARows: dd 2
	ACols: dd 2
	Aadrs: dd 0
	; size of matrix 2 x 2
	matrixB: dd 1,1,0,1
	BRows: dd 2
	BCols: dd 2
	Badrs: dd 0
	matrixC: dd 0,0,0,0
	CRows: dd 2
	CCols: dd 2
	Cadrs: dd 0
	
	temp: dd 0
SECTION .bss ; declaring variables




SECTION .text ; code part

global main

main:
	;call printIntro	
	
firstLoop:
	; compare the i value if i value equals to no of rows then go and exit
	; otherwise goto second loop
	;call printIntro
	mov eax,[i]
	mov ebx,[CRows]
	add ebx,1
	cmp eax,ebx
	je ssexit

;	call printRow
;	mov [globalNum],eax
;	printNumber eax

	; Intailizing the J value as 1
	mov eax,1
	mov [j],eax
	; Entry of secondLoop
	secondLoop:
		;call printIntro
		; if j value equals to no of columns then go and increment the i value 
		; if not equals go to inside of secondLoop
		mov eax,[j]
		mov ebx,[CCols]
		add ebx,1
		cmp eax,ebx
		je incIVal

;		call printCol
;		mov [globalNum],eax
;		printNumber eax
		; convert a[i][j] to [a + ?]

		mov ecx,[i]
		mov edx,[j]
		mov ebx,[CCols]
		call rcToAddress
		; now eax contains address 
		;call printIntro
		mov [Cadrs],eax
			
			mov eax,0
			mov [temp],eax
			mov eax,1
			mov [k],eax
			thirdLoop:
				;call printIntro
				; if k no of rows are completed then go and increase the j value
				mov eax,[k]
				mov ebx,[ACols]
				add ebx,1
				cmp eax,ebx
				je assignAndIncJval
				
;				call printThird 
;				mov [globalNum],eax
;				printNumber eax
				
				; address of Matrix A
				mov ecx,[i]
				mov edx,[k]
				mov ebx,[ACols]
				call rcToAddress
				mov [Aadrs],eax
				
				; address of Matrix B
				mov ecx,[k]
				mov edx,[j]
				mov ebx,[BCols]
				call rcToAddress
				mov [Badrs],eax
				
				; Multiplication
				mov ebx,[Aadrs]
				mov ecx,[matrixA+ebx]
				mov ebx,[Badrs]
				mov edx,[matrixB+ebx]
				
				;;;;;;;;;call printIntro
				call multiply

				mov ebx,[temp]
				add ebx,eax
				mov [temp],ebx
				
				; incrementing k value
				mov eax,[k]
				inc eax
				mov [k],eax
				jmp thirdLoop
				
				assignAndIncJval:
					mov eax,[temp]
					mov ebx,[Cadrs]
					mov [matrixC+ebx],eax
					
					mov [globalNum],eax
					printNumber eax

					jmp incJVal
				
		; incrementing j value 
		; the correct address value is stored in eax value
		incJVal:
			mov eax,[j]
			inc eax
			mov [j],eax
			jmp secondLoop
	incIVal:	
	; incrementing i value	
	mov eax,[i]
	inc eax
	mov [i],eax
	jmp firstLoop
	
; exit(0)
ssexit:
mov eax,0
ret
