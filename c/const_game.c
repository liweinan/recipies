#include <stdio.h>

int main() {

  // ptr:readonly, type:readonly
  int i = 1;
  int j = 2;
  const int *const apple = &i;
  printf("apple:%d\n", *apple);
  // const_game.c:10:9: error: read-only variable is not assignable
  // apple = &j;
  // *apple = 2;

  int *const pear = &i;
  *pear = 2;
  printf("pear:%d\n", *pear);
  // const_game.c:17:8: error: read-only variable is not assignable
  // pear = &j;

  return 1;
}
