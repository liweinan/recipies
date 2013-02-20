all: simple_tracer eatsyscall

simple_tracer: simple_tracer.c
	$(CC) simple_tracer.c -o $@

eatsyscall: eatsyscall.asm
	nasm -f elf eatsyscall.asm
	ld -s -o eatsyscall eatsyscall.o

test1: simple_tracer eatsyscall
	./simple_tracer eatsyscall

clean:
	rm -rf *.o
	rm simple_tracer eatsyscall
