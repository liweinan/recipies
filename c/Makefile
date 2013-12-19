default: fwrite.o nonblock.o vfork.o stdarg.o zombie.o process.o zombie_fix.o getenv.o null.o

getenv.o: getenv.c
	$(CC) getenv.c -o $@

fwrite.o: fwrite.c
	cc fwrite.c -o fwrite.o

nonblock.o: nonblock.c
	cc nonblock.c -o nonblock.o

stdarg.o: stdarg.c
	cc stdarg.c -o stdarg.o

zombie.o: zombie.c
	cc zombie.c -o zombie.o

zombie_fix.o: zombie_fix.c
	cc zombie_fix.c -o zombie_fix.o


vfork.o: vfork.c
	cc vfork.c -o vfork.o

process.o: process.c
	cc process.c -o process.o

play_fwrite: nonblock.o
	./nonblock.o < test.txt > out.tmp
	cat out.tmp

play_fork: vfork.o
	./vfork.o

play_stdarg: stdarg.o
	./stdarg.o

null.o: null.c
	cc null.c -o null.o

hostname.o: hostname.c
	cc hostname.c -o hostname.o

gethostbyaddr: gethostbyaddr.c
	cc $< -o $@

enum: enum.c
	cc $< -o $@

perror: perror.c
	cc $< -o $@

endian: endian.c lib/common.c
	cc endian.c lib/common.c -o $@

ptr: ptr.c
	cc ptr.c -o ptr

const_game: const_game.c
	cc const_game.c -o const_game

decl: decl.c
	cc decl.c -o decl

clean:
	rm *.o
	rm *.tmp
	rm *.out

.PHONY: clean
