#include <stdio.h>
#include <string.h>

int main() {
  char str[5];
  char dst[5];
  memset(str, 'A', 5);
  str[4] = '\0';
  memcpy(dst, str, 5); // dst = str
  printf("str: %s\n", str);
  printf("dst: %s\n", dst);
  printf("cmp: %d\n", memcmp(str, dst, 5));
  return 0;
}
