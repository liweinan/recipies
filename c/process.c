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
	if ((pid = fork()) < 0) { /* 创建新的进程 */
		err_sys("fork error");
	} else if (pid == 0) { /* fork向孩子进程返回0 */
		/* 所以只有孩子进程会执行到这里 */
		puts("child process here."); 
		puts("child process will sleep for 10 seconds...");
		sleep(10);
	} else { /* fork向父进程返回孩子进程的PID */
		/* 所以只有父进程会执行到这里 */
		puts("parent process here.");
		printf("parent get the child pid: %d\n", pid);
	}
	
	/* 父亲孩子共用的代码部分 */
	sleep(3);
	
	if (pid == 0) { /* 孩子进程 */
		puts("child process exit.");
	} else { /* 父亲进程 */
		puts("parent process exit.");
	}
	
	/* 共用代码 */
	return 0;
}

void err_sys(const char* fmt, ...) {
	/* man stdarg to see the instructions on va_list */
	va_list ap;
	fprintf(stderr, fmt, ap);
	exit(1);
}
