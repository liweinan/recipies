#include <sys/wait.h>

int main(int argc, char *argv[]) {
  int pfd[2];

  if (pipe(pfd) == -1)
    exit(1);

  switch (fork()) {
  case -1:
    exit(1);

  case 0:
    // child
    if (close(pfd[0] == -1) // read end is used
	exit(1);
