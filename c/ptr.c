#include <stdio.h>

char a = 'a';
char b = 'b';
char *ptr_a;
char *ptr_b;

void inc(char* ptr) {
	++*ptr;
	++*ptr_b;
}

int main() {
	ptr_a = &a;
	ptr_b = &b;
	
	inc(ptr_a);
	
	printf("%c %c\n", *ptr_a, *ptr_b);
}