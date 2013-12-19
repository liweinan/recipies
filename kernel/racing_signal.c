#include <signal.h> // signal
#include <sys/resource.h> // getpriority, setpriority
#include <unistd.h> // getpid, getppid
#include <stdlib.h> // exit
#include <stdio.h> // printf
#include <limits.h> // INT_MAX

int i,j;

void my_handler() {
  printf(".");
//   for (i = 0; i < INT_MAX; i++) {
//     j = i;
//     while (j > 0) {
//       j--;
//     }
//   }
  signal(SIGINT, my_handler); // This will be supressed by context switching.
}

int main() {
  int ppid;

  signal(SIGINT, my_handler);

  if (fork() == 0) {
    sleep(5); // Let parent process finish set priority.
    ppid = getppid(); // sending signal to parent process.
    //while (1) {
      if(kill(ppid, SIGINT) == -1) { // This will happen because of the racing condition.
        printf("X");
        exit(-1);
      }
      //}
  }
  setpriority(PRIO_PROCESS, getpid(), -20); // Parent process will have more chances of context switching. 
  while (1) {

  }
}
