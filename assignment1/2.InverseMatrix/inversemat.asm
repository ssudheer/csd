; Computer System Design Lab, Assignment-1
; Inverse of the Matrix

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
printDeterminent:
	printString " Determinent is "
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
	pop ebx
	
ret	
Minor:
	; eax ebx
	; ecx edx
	imul eax,edx
	imul ebx,ecx
	sub eax,ebx
	
ret
Determinent:
	
	; minor 1
	mov eax,[MatrixA+16]
	mov ebx,[MatrixA+20]
	mov ecx,[MatrixA+28]
	mov edx,[MatrixA+32]
	call Minor
	mov [temp1],eax
		
;	mov [globalNum],eax
;	printNumber eax
	
	; minor 2
	mov eax,[MatrixA+12]
	mov ebx,[MatrixA+20]
	mov ecx,[MatrixA+24]
	mov edx,[MatrixA+32]	
	call Minor
	mov [temp2],eax
	
	;mov [globalNum],eax
	;printNumber eax
	
	
	; minor 3
	mov eax,[MatrixA+12]
	mov ebx,[MatrixA+16]
	mov ecx,[MatrixA+24]
	mov edx,[MatrixA+28]	
	call Minor
	mov [temp3],eax

	;mov [globalNum],eax
	;printNumber eax
	
	
	mov eax,[MatrixA]
	mov ebx,[temp1]	
	imul eax,ebx
	mov [temp1],eax
	
	;	mov [globalNum],eax
	;printNumber eax

	
	mov eax,[MatrixA+4]
	mov ebx,[temp2]
	imul eax,ebx
	mov [temp2],eax
	;		mov [globalNum],eax
	;printNumber eax

	mov eax,[MatrixA+8]
	mov ebx,[temp3]
	imul eax,ebx
	mov [temp3],eax
;			mov [globalNum],eax
;	printNumber eax

	
	mov eax,[temp1]
	mov ebx,[temp2]
	sub eax,ebx
	mov ecx,[temp3]
	add eax,ecx
	
	mov [Det],eax
	
	; Determinent value is stored in eax value
ret

transposeMatrix:
	mov eax, [MatrixA]
	mov [InvMatrixA],eax
	mov eax,[MatrixA+16]
	mov [InvMatrixA+16],eax
	mov eax,[MatrixA+32]
	mov [InvMatrixA+32],eax
	
	mov eax,[MatrixA+12]
	mov [InvMatrixA+4],eax	

	mov eax,[MatrixA+24]
	mov [InvMatrixA+8],eax

	mov eax,[MatrixA+4]
	mov [InvMatrixA+12],eax

	mov eax,[MatrixA+28]
	mov [InvMatrixA+20],eax	

	mov eax,[MatrixA+8]
	mov [InvMatrixA+24],eax
	
	mov eax,[MatrixA+20]
	mov [InvMatrixA+28],eax
ret
printInverseMatrix:
	firstLoop:
		; compare the i value if i value equals to no of rows then go and exit
		; otherwise goto second loop
		;call printIntro
		mov eax,[i]
		mov ebx,9
		add ebx,1
		cmp eax,ebx
		je ssi
		
		dec eax
		imul eax,4
		mov ebx,[InvMatrixA+eax]
		mov [globalNum],ebx
		printNumber ebx
		incIVal:	
			; incrementing i value	
			mov eax,[i]
			inc eax
			mov [i],eax
			jmp firstLoop
	ssi:
ret			
calculate:
	
	; Minor m11
	mov eax,[InvMatrixA+16]
	mov ebx,[InvMatrixA+20]
	mov ecx,[InvMatrixA+28]
	mov edx,[InvMatrixA+32]
	call Minor
	mov [m11],eax
	
	; Minor m12
	mov eax,[InvMatrixA+12]
	mov ebx,[InvMatrixA+20]
	mov ecx,[InvMatrixA+24]
	mov edx,[InvMatrixA+32]
	call Minor
	mov [m12],eax
	; Minor m13
	mov eax,[InvMatrixA+12]
	mov ebx,[InvMatrixA+16]
	mov ecx,[InvMatrixA+24]
	mov edx,[InvMatrixA+28]
	call Minor
	mov [m13],eax
	; Minor m21
	mov eax,[InvMatrixA+4]
	mov ebx,[InvMatrixA+8]
	mov ecx,[InvMatrixA+28]
	mov edx,[InvMatrixA+32]
	call Minor
	mov [m21],eax
	; Minor m22
	mov eax,[InvMatrixA+0]
	mov ebx,[InvMatrixA+8]
	mov ecx,[InvMatrixA+24]
	mov edx,[InvMatrixA+32]
	call Minor
	mov [m22],eax
	; Minor m23
	mov eax,[InvMatrixA+0]
	mov ebx,[InvMatrixA+4]
	mov ecx,[InvMatrixA+24]
	mov edx,[InvMatrixA+28]
	call Minor
	mov [m23],eax
	; Minor m31
	mov eax,[InvMatrixA+4]
	mov ebx,[InvMatrixA+8]
	mov ecx,[InvMatrixA+16]
	mov edx,[InvMatrixA+20]
	call Minor
	mov [m31],eax
	; Minor m32
	mov eax,[InvMatrixA+0]
	mov ebx,[InvMatrixA+8]
	mov ecx,[InvMatrixA+12]
	mov edx,[InvMatrixA+20]
	call Minor
	mov [m32],eax
	; Minor m33
	mov eax,[InvMatrixA+0]
	mov ebx,[InvMatrixA+4]
	mov ecx,[InvMatrixA+12]
	mov edx,[InvMatrixA+16]
	call Minor
	mov [m33],eax
	
	mov eax,[m11]
	mov [InvMatrixA],eax
	mov eax,[m12]
	imul eax,-1
	mov [InvMatrixA+4],eax
	mov eax,[m13]
	mov [InvMatrixA+8],eax
	
	mov eax,[m21]
	imul eax,-1
	mov [InvMatrixA+12],eax
	mov eax,[m22]
	mov [InvMatrixA+16],eax	
	mov eax,[m23]
	imul eax,-1
	mov [InvMatrixA+20],eax
	
	mov eax,[m31]
	mov [InvMatrixA+24],eax
	mov eax,[m32]
	imul eax,-1
	mov [InvMatrixA+28],eax
	mov eax,[m33]
	mov [InvMatrixA+32],eax

ret
SECTION .data
	strfmt: db " %s ",10,0	; format string for printf
	numfmt: db " %d ",10,0
	globalNum: dd 0
	i: dd 1
	j: dd 1
	k: dd 1
	;MatrixA: db 1,2,3,4,5,6,7,8,9
	MatrixA: dd 1,2,3,0,1,4,5,6,0
	InvMatrixA: dd 0,0,0,0,0,0,0,0,0
	ARows: dd 3
	ACols: dd 3
	Det: dd 0
	temp1: dd 0
	temp2: dd 0
	temp3: dd 0
	m11: dd 0
	m12: dd 0
	m13: dd 0
	m21: dd 0
	m22: dd 0
	m23: dd 0
	m31: dd 0
	m32: dd 0
	m33: dd 0

SECTION .text

global main

main:
	call printDeterminent
	call Determinent
	mov [globalNum],eax
	printNumber eax
	call transposeMatrix	
	call calculate
	call printInverseMatrix
	
; exit(0)
ssexit:
mov eax,0
ret
