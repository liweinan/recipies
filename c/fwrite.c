#include <fcntl.h>
#include <stdio.h>

#define BUFSIZE 100

int main() {

	FILE *fp;
	fp=fopen("test.txt", "wb");
	char x[BUFSIZE]="ABCDEFGHIJ\0";
	
	printf("char: %s\n", x);
	
	fwrite(x, sizeof(x[0]), sizeof(x)/sizeof(x[0]), fp);

}