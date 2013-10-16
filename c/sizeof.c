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
    printf("sizeof(unsigned char): %d\n", (int) sizeof(unsigned char));
	
	printf("sizeof(int): %d\n", (int) sizeof(int));
	printf("sizeof(double): %d\n", (int) sizeof(double));
	
    printf("0xff + 0xff: %x\n", 0xff + 0xff);
    int i = 0xffffffff;
    printf("0xff ff ff ff + i: %x\n", 0xffffffff + i); // overflow
}