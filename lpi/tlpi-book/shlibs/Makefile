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