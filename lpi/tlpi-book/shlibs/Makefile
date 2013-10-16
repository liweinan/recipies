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

show_ldd: prog_soname
	LD_LIBRARY_PATH=. ldd prog_soname

linker_name:
	@rm -rf *.so *.so.* *.so.*.* *.so.*.*.*
	@rm -rf *.o
	gcc -g -c -fPIC -Wall mod1.c mod2.c mod3.c
	gcc -g -shared -Wl,-soname,libdemo.so.1 -o libdemo.so.1.0.1 \
		mod1.o mod2.o mod3.o
	ln -s libdemo.so.1.0.1 libdemo.so.1
	ln -s libdemo.so.1 libdemo.so

linker_name2:linker_name
	gcc -g -shared -Wl,-soname,libdemo.so.1 -o libdemo.so.1.0.2 \
		mod1.o mod2.o mod3.o


play_with_ldconfig: linker_name2
	@sudo rm -f /usr/lib/libdemo*
	sudo mv libdemo.so.1.0.1 /usr/lib
	sudo ldconfig -v | grep libdemo
	@sudo rm -f /usr/lib/libdemo.so
	cd /usr/lib;sudo ln -s libdemo.so.1 libdemo.so;cd -
	ls -la /usr/lib/libdemo*
	@sudo rm -f /usr/lib/libdemo.so.1.0.2
	sudo mv libdemo.so.1.0.2 /usr/lib
	sudo ldconfig -v | grep libdemo
	ls -la /usr/lib/libdemo*

use_linker_name: linker_name
	gcc -g -Wall -o prog_linker_name prog.c -L. -ldemo
	LD_LIBRARY_PATH=. ./prog_linker_name