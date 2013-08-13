# Makefile for Matrix Multiplication
all:hello.out

hello.out: inversemat.asm
	nasm -f elf32 -l inversemat.lst inversemat.asm
	gcc -m32 -o inversemat  inversemat.o
	#matrixmul > matrixmul.out
	#make clean
	./inversemat


clean:
	rm -f *.o
	rm -f *.lst
	rm -f inversemat
	rm -f *.out

