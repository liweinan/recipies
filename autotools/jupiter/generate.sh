#!/bin/sh
rm -rf src Makefile
touch Makefile
cat <<EOF >> Makefile
all clean jupiter:
	cd src && \$(MAKE) \$@

.PHONY: all clean
EOF

mkdir src
touch src/Makefile
cat <<EOF >> src/Makefile
all: jupiter

jupiter: main.c
	gcc -g -o \$@ main.c

clean:
	-rm jupiter

.PHONY: all clean
EOF

touch src/main.c
cat <<EOF >> src/main.c
#include <stdio.h>

int main(void) {
    printf("Hello, world!");
}
EOF