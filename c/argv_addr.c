#include <stdio.h>

int main(int argc, char *argv[]) {
	char **p = argv;
	while (*p != NULL) {
		printf("&p -> %x p -> %x *p -> %x *p -> %s\n", &p, p, *p, *p);
		p++;
	}
}
