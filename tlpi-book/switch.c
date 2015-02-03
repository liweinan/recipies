#include <stdio.h>

int main() {
  int i;
  int j = 1;
  for (i = 0; i < 10; i++) {
    switch(j) {
    default:
      break;
    }
    printf("herehere!\n");
  }

  for (i = 0; i < 3; i++) {
    for (j = 0; j < 3; j++) {
      break;
    }
    printf("therethere!\n");
  }
}
