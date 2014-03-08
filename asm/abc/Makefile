abc: main.o abc.o
	ld -o abc main.o abc.o
main.o: main.asm
	nasm -f elf -g -F stabs main.asm -o main.o
abc.o: abc.asm
	nasm -f elf -g -F stabs abc.asm -o abc.o
