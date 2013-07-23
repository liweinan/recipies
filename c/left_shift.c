#include <stdio.h>
#include <string.h>

const char* byte_to_binary(int x) {
  static char b[9];
  b[0] = '\0'; // little endian

  int z;
  // 2^7 = 128. 8 bits
  for (z = 128; z > 0; z >>= 1) {
	strcat(b, ((x & z) == z) ? "1" : "0");
  }

  return b;
}


int main(void) {
	unsigned char mask;
	for (mask = 0x01; mask; mask <<=1) {
		printf("%s ", byte_to_binary(mask));
	}
	printf("\n");
}

