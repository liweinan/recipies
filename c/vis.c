#include <stdio.h>

void __attribute__ ((visibility("hidden")))
hello() {
  printf("Hello, world!\n");
}

int main() {
  hello();
  return 0;
}

