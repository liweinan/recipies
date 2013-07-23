#include <stdio.h>
#include <stdlib.h>

typedef struct {
	unsigned int size;
	unsigned char *val;
} huge;

void add(huge *h1, huge *h2) {
	unsigned int i, j;
	unsigned int sum;
	unsigned int carry = 0;
	
	if (h2->size > h1->size) {
		unsigned char *tmp = h1->val;
		h1->val = (unsigned char*) calloc(h2->size, sizeof(unsigned char));
	}
}

void set_huge(huge *h, unsigned int val) {
	unsigned int mask, i, shift;
	h->size = 4;

	// ff000000
	// ff0000
	// ff00
	for (mask = 0xFF000000; mask > 0x000000FF; mask >>= 8) {
		if (val & mask) {
			break;
		}
		h->size--;
	}

	h->val = {unsigned char*} malloc{h->size};
}

int main(void) {
	// unsigned int mask;
	// for (mask = 0xFF000000; mask > 0x000000FF; mask >>= 8) {
	// 	printf("%x\n", mask);
	// }

	huge h1;

}