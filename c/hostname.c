#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  char* hn = malloc(sizeof(char) * 100);
  gethostname(hn, sizeof(char) * 100);
  printf("hostname: %s\n", hn);
}
