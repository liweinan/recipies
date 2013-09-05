include ../Makefile.inc

GEN_EXE = dynload

LINUX_EXE =

EXE = ${GEN_EXE} ${LINUX_EXE}

all : ${EXE}

allgen : ${GEN_EXE}

dynload : dynload.o
	${CC} -o $@ dynload.o ${CFLAGS} ${LDLIBS} ${LINUX_LIBDL}

clean :
	${RM} ${EXE} *.o *.so.*

${EXE} : ${LPLIB}		# True as a rough approximation

basic: prog.c mod1.c mod2.c mod3.c
	cc -g -c prog.c mod1.c mod2.c mod3.c

prog_nolib: basic
	cc -g -o prog_nolib prog.o mod1.o mod2.o mod3.o

prog: static_lib
	cc -g -o prog prog.o -ldemo -L.

static_lib: basic
	ar r libdemo.a mod1.o mod2.o mod3.o
	ar t libdemo.a

shared_lib: mod1.c mod2.c mod3.c
	rm -f mod1.o mod2.o mod3.o
	gcc -g -c -fPIC mod1.c mod2.c mod3.c
	gcc -g -shared -o libfoo.so mod1.o mod2.o mod3.o

check_shared_lib: shared_lib
# - means ignore the bad exit value
	-nm mod1.o | grep _GLOBAL_OFFSET_TABLE_
	-readelf -s mod1.o | grep _GLOBAL_OFFSET_TABLE_

soname: mod1.c mod2.c mod3.c
	gcc -g -c -fPIC -Wall mod1.c mod2.c mod3.c
	gcc -g -shared -Wl,-soname,libbar.so -o libfoo.so mod1.o mod2.o mod3.o

read_soname: soname
	objdump -p libfoo.so | grep SONAME
	readelf -d libfoo.so | grep SONAME

prog_soname: soname prog.c
	gcc -g -Wall -o prog_soname prog.c libfoo.so

run_prog_soname: prog_soname
	-@rm -rf libbar.so
	ln -s libfoo.so libbar.so
	LD_LIBRARY_PATH=. ./prog_soname