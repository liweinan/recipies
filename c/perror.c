#include <stdio.h>
#include <stdlib.h>

int main() {
  int fd = open('/tmp/void');
  printf("result %d\n", fd);
  return 0;
}
