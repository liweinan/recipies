#include <stdio.h>
#include <stdlib.h>
#include <ioctl.h>

void errExit(char* reason) {
    exit(-1);
}

int main(int argc, char* argv) {
    fd = open(argv[1], O_WRONLY); /* Open 1: check if file exists */
    if (fd != -1) { /* Open succeeded */
        printf("[PID %ld] File \"%s\" already exists\n", (long) getpid(), argv[1]);
        return close(fd);
    } else {
        if (errno != ENOENT) {
            errExit("open");
            /* Failed for unexpected reason */
        } else {
            /* WINDOW FOR FAILURE */
            fd = open(argv[1], O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR);
            if (fd == -1)
                errExit("open");
            printf("[PID %ld] Created file \"%s\" exclusively\n", 
                (long) getpid(), argv[1]);
            /* MAY NOT BE TRUE! */
        }
    }
}