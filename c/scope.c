/*
power:c weli$ nm ./a.out
...
0000000100001000 b _main.y
0000000100001004 b _x
...
*/

#include <stdio.h>

static int x;

int main(void) {
	static int y;
	
	x = 1;
	y = 2;
}