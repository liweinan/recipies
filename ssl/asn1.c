#include <stdio.h>

int main() {
	int i;
	for (i = 0; i < 129; i++) {
		if ((i&0x1f) == 0x1f) {
			printf("%d & 0x1F: 0x%x\n", i, i&0x1f); 
		}
	}
}