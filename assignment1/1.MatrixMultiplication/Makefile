# Makefile for Matrix Multiplication
all:hello.out

hello.out: matrixmul.asm
	nasm -f elf32 -l matrixmul.lst matrixmul.asm
	gcc -m32 -o matrixmul  matrixmul.o
	#matrixmul > matrixmul.out
	#make clean
	./matrixmul


clean:
	rm -f *.o
	rm -f *.lst
	rm -f matrixmul
	rm -f *.out
