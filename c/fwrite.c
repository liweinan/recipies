#include <fcntl.h>
#include <stdio.h>

#define BUFSIZE 100

int main() {

	FILE *fp;
	fp=fopen("/tmp/test.txt", "wb");
	char x[BUFSIZE]="ABCDEFGHIJ\0";
	
	printf("char: %s\n", x);

 mini:c weinanli$ od -ch /tmp/test.txt
0000000    A   B   C   D   E   F   G   H   I   J  \0  \0  \0  \0  \0  \0
             4241    4443    4645    4847    4a49    0000    0000    0000
0000020   \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
             0000    0000    0000    0000    0000    0000    0000    0000
*
0000140
	
	fwrite(x, sizeof(x[0]), sizeof(x)/sizeof(x[0]), fp);

}
