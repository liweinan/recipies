#include <stdio.h>
#include <string.h>

int main() {
	char *p = "/abc";
	printf("%s\n", strrchr(p, '/'));
}