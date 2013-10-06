#include <stdio.h>

enum _ok { YES, NO }
enum _ok _yes = YES;

int main() {
  printf("%d\n", _yes);
  return 0;
}
