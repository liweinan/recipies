source_files = $(shell find ../src -type f -iname '*.c' | sed 's/^\.\.\/src\///')
obj_files = $(subst .c,.o,$(source_files))
 
LDFLAGS =
CFLAGS = -g
 
vpath %.c ../src/
 
all: bin
 
bin: $(obj_files)
    gcc $(LDFLAGS) $^ -o $@
 
%.o: %.c
    -mkdir -p $(dir $@)
    gcc $(CFLAGS) $< -c -o $@
 
.PHONY: all clean
 
clean:
    rm -rf $(obj_files) $(dir $(obj_files)) bin