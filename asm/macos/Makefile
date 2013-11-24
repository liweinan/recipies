default: hello
hello: hello.o
	ld -e main -o hello hello.o 
hello.o: hello.asm
	nasm -f macho -g hello.asm
