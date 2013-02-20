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

void err_sys(const char* fmt, ...);

int main () {
	pid_t pid;
	if ((pid = fork()) < 0) { /* create a process */
		err_sys("fork error");
	} else if (pid == 0) { /* child process */
		/* Child process exit immediately.
		 * It will create a zombie process, 
		 * and waiting for parent to handle it. */
		exit (0); 
	} else {
		/* Parent process sleep, so we can see */
		/* child process in zombie state. */
		fputs("parent process goes to sleep...", stderr);
		sleep (60); 
	}
	return 0;
}

void err_sys(const char* fmt, ...) {
	/* man stdarg to see the instructions on va_list */
	va_list ap;
	fprintf(stderr, fmt, ap);
	exit(1);
}
