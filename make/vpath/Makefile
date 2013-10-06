vpath %.c src
vpath %.h include
CPPFLAGS = -I include

main: hello.c main.c hello.h
	gcc $(CPPFLAGS) $^ -o $@

.PHONY: clean
clean:
	@rm -rf main