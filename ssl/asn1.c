#include <stdio.h>
#include <stdlib.h>

int main() {
	int i;
	for (i = 0; i < 129; i++) {
		if ((i&0x1f) == 0x1f) {
			printf("%d & 0x1F: 0x%x\n", i, i&0x1f); 
		}
	}
	
	printf("sizeof(unsigned int): %d\n", (int) sizeof(unsigned int));
	
	unsigned int j = 1;
	for (i = 0; i < 4; i++) {
		j <<= 8;
		printf("j << 8: %d\n", j);		
	}

	unsigned char *buffer = (unsigned char*) malloc(2);
	const unsigned char *ptr;
	
	ptr = buffer;

	unsigned char tag_length_byte;
	unsigned int tag;
	
	tag = *ptr;
	tag <<= 8;
    tag |= *ptr & 0x7F;
	


}