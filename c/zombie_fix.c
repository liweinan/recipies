/* exit() */
#include <stdlib.h>

#include <sys/types.h>

/*
 * fork()
 */
#include <unistd.h>

/* 
 * stderr
 * stdout
 * fprintf
 */
#include <stdio.h>

/* We'll catch SIGCHLD signal to know that child process has quit */
#include <signal.h>

void err_sys(const char* fmt, ...);

static void child_quit(int);

int main () {
	pid_t pid;
	int i;
	if ((pid = fork()) < 0) { /* create a process */
		err_sys("fork error");
	} else if (pid == 0) { /* child process */
		/* Child process will quit after 3 seconds.
		 * It will create a zombie process, 
		 * and waiting for parent to handle it. */
		puts("child process start.");
		sleep(3);
		exit (0); 
	} else {
		if (signal(SIGCHLD, child_quit) == SIG_ERR)
			err_sys("cannot register signal handler for SIGCHLD!");
		puts("signal handler registered for SIGCHLD.");
		/* Parent process will do some work now */
		for (i = 0; i < 10; i++) {
			sleep (1); 
			printf("#%d: parent is doing work.\n", i);
		}
		
	}
	return 0;
}

static void child_quit(int signo) {
	wait(NULL);
	puts("child process quit.");
}

void err_sys(const char* fmt, ...) {
	/* man stdarg to see the instructions on va_list */
	va_list ap;
	fprintf(stderr, fmt, ap);
	exit(1);
}
