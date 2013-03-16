vpath %.c src
vpath %.h include

main: hello.c main.c hello.h
	gcc -I include $^ -o $@

.PHONY: clean
clean:
	rm -rf main