#include <stdio.h>

int main(void) {
  int i;
  for (i = 1; i != 8; i = (i+2) % 9) {
	printf("%d ", i);
  }
}
