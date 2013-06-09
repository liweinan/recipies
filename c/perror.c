#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

int main() {
  int fd = open("/tmp/void", O_RDONLY | O_CREAT);
  perror("result");
  return 0;
}
