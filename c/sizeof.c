#include <stdio.h>

/*
sizeof(char): 1
sizeof(char[3]): 3
sizeof(int): 4
sizeof(double): 8
*/
int main(void) {
	printf("sizeof(char): %d\n", (int) sizeof(char));
	char chars[3];	
	printf("sizeof(char[3]): %d\n", (int) sizeof(chars));
	
	printf("sizeof(int): %d\n", (int) sizeof(int));
	printf("sizeof(double): %d\n", (int) sizeof(double));
	
}