#include <stdio.h>

int main() {
	char *fruits[] = {"Apple","Orange","Kiwi"};
	for (int i = 0; i < 3; i++) {
		printf("%s\n", fruits[i]);
	}
	
	char (*ptr_fruits)[];
	ptr_fruits = fruits;	
}