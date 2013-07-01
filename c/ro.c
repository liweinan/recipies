/*
 * weli$ cc ro.c
 * power:c weli$ ./a.out
 * before: Hello
 * Bus error: 10
 */ 

#include <stdio.h>

int main() {
	char *ptr = "Hello";
	printf ("before: %s\n", ptr);
	
	ptr[0] = 'A'; // modify readonly memory
	printf ("after: %s\n", ptr);
}