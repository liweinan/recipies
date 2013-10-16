#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(void) {
	int *p = calloc(1, sizeof(int));	
	printf("p -> %p\n", p);	
	p = calloc(1, sizeof(int));
	printf("p -> %p\n", p);
	
	*p = 42;
	int *pp = calloc(2, sizeof(void));
	printf("*pp[0]: %p pp[1]: %p\n", &pp[0], &pp[1]);
	printf("*pp[0]: %2d pp[1]: %2d\n", pp[0], pp[1]);
	memcpy(pp, p, 1);
	printf("*pp[0]: %2d pp[1]: %2d\n", *pp, *(pp + 1));
	memcpy(&pp[1], p, 1);
	printf("*pp[0]: %2d pp[1]: %2d\n", pp[0], pp[1]);

}