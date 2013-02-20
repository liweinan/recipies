/* 
 * References:
 * http://stackoverflow.com/questions/1150635/unix-nonblocking-i-o-o-nonblock-vs-fionbio
 * http://www.apuebook.com/
 */
 
/* 
 * set_fl()
 * fcntl()
 */
#include <fcntl.h> 

/* 
 * read()
 * STDIN_FILENO
 * STDIN_FILENO is int type, and stdin is FILE* type defined in <stdio.h>
 */
#include <unistd.h>

/*
 * fprintf()
 * stderr()
 */
#include <stdio.h>

/* errno */
#include <errno.h>

/* exit() */
#include <stdlib.h>

/* 
 * 1024*1024
 * buffer must be large enough for nonblocking write to show effects.
 */ 
#define BUFSIZE 1048576 

char buf[BUFSIZE];

void set_fl(int fd, int flags);
void clr_fl(int fd, int flags);
void err_sys(const char* fmt, ...);

int main() {
	int ntowrite, nwrite;
	char* ptr;
	
	ntowrite = read(STDIN_FILENO, buf, sizeof(buf)); /* it's a blocking read */
	fprintf(stderr, "read %d bytes\n", ntowrite);
	
	set_fl(STDOUT_FILENO, O_NONBLOCK); /* set nonblocking */
	
	for (ptr = buf; ntowrite > 0;) {
		errno = 0;
		nwrite = write(STDOUT_FILENO, ptr, ntowrite); /* performs nonblock reading */
		fprintf(stderr, "nwrite = %d, errno = %d\n", nwrite, errno);
		if (nwrite > 0) {
			ptr += nwrite; /* move pointer to unread bytes */
			ntowrite -= nwrite; /* countdown left bytes to read */
		}
	}
	
	set_fl(STDOUT_FILENO, O_NONBLOCK); /* set back to blocking */
	
	exit(0); /* reference: man 3 exit */
}

/* flags are the file status flags to turn on */
void set_fl(int fd, int flags) {
	int val;	
	
	if ((val = fcntl(fd, F_GETFL, 0)) < 0)
		err_sys("set_fl: fcntl F_GETFL error");
		
	val |= O_NONBLOCK;
	
	if (fcntl(fd, F_SETFL, val) < 0)
		err_sys("set_fl: fcntl F_SETFL error");
}

/* flags are the file status flags to turn off */
void clr_fl(int fd, int flags) {
	int	val;

	if ((val = fcntl(fd, F_GETFL, 0)) < 0)
		err_sys("clr_fl: fcntl F_GETFL error");

	val &= ~flags;		/* turn flags off */

	if (fcntl(fd, F_SETFL, val) < 0)
		err_sys("clr_fl: fcntl F_SETFL error");
}

void err_sys(const char* fmt, ...) {
	va_list ap;
	fprintf(stderr, fmt, ap);
	exit(1);
}
