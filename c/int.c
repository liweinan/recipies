#include <stdio.h>

int main(void) {
/*
movb	$1, -1(%rbp)
movl	$2, -8(%rbp)
movq	$3, -16(%rbp)
*/
	char a = '\1';
	int b = 2;
	long c = 3;
	
	printf("%c%d%ld", a, b, c);
	
}