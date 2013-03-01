#include <stdio.h>
#include <stdlib.h>

extern int _a, _b, _c;
extern int yylex(void);

int main(int argc, char** argv) {
	yylex();
	printf("%d %d %d\n", _a, _b, _c);
	exit(0);
}
