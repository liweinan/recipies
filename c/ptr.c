#include <stdio.h>

char a = 'a';
char b = 'b';
char *ptr_a;
char *ptr_b;

char *x = "xx";
char *y = "yy";

void inc(char* ptr) {
	++*ptr;
	++*ptr_b;
}

void ptr(char **ptr_x, char **ptr_y) {
	printf("ptr_x: %d ptr_y: %d\n", ptr_x, ptr_y);
	printf("&ptr_x: %d &ptr_y: %d\n", &ptr_x, &ptr_y);
}

int main() {
	ptr_a = &a;
	ptr_b = &b;
	
	inc(ptr_a);
	
	printf("%c %c\n", *ptr_a, *ptr_b);
	
	printf("x: %d y: %d\n", (int) x, (int) y);
	ptr(&x, &y);
	
}