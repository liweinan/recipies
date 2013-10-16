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

// input: 7 bytes
static void rol(unsigned char *target) {
	int carry_left, carry_right;
	carry_left = (target[0] & 0x80) >> 3; // YXXX XXXX -> 0000 000Y
	target[0] = (target[0] << 1) | ((target[1] & 0x80) >> 7);
	target[1] = (target[1] << 1) | ((target[2] & 0x80) >> 7);
	target[2] = (target[2] << 1) | ((target[3] & 0x80) >> 7);
	
	carry_right = (target[3] & 0x08) >> 3; // XXXX YXXX -> 0000 000Y	
	target[3] = (((target[3] << 1) | ((target[4] & 0x80) >> 7)) & ~0x10) | carry_left;
	target[4] = (target[4] << 1) | ((target[5] & 0x80) >> 7);
	target[5] = (target[5] << 1) | ((target[6] & 0x80) >> 7);
	target[6] = (target[6] << 1) | carry_right;
}

int main(void) {
	unsigned char input[] = "\1\0\1\0\1\0\1";
	int i = 0;
	int j = 0;
	for (; i<7; i++) {
		printf("%s ", byte_to_binary((int)input[i]));
	}
	printf("\n");
	for(; j<28; j++) {
		rol(input);
		for (i=0; i<7; i++) {
			printf("%s ", byte_to_binary((int)input[i]));
		}
		printf("\n");
	}
}


