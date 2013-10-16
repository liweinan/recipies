#include <arpa/inet.h>
#include <stdio.h>

int main(void) {
	uint16_t a = 13;
	uint16_t b = 1;
	uint16_t c = 32768; // 2^15
	uint16_t d = 32770; // 1000 0000 0000 0010
	printf("%d ", a);
	printf("%d ", htons(a));
	printf("%d ", b);
	printf("%d ", htons(b));
	printf("%d ", c);
	printf("%d ", htons(c));
	printf("%d ", d);
	printf("%d ", htons(d)); // 0000 0010 1000 0000
	
	printf("\nsizeof(short) %d\n", (int) sizeof(short));
}
