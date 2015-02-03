#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <stdio.h>
#include <fcntl.h> // for open
#include <unistd.h> // for close
#include <string.h>
#include <err.h>
#include <stdio.h>

int main(void) {
    struct addrinfo hints, *res, *res0;
    int error;
    int s;
    const char *cause = NULL;
    char buffer[50];

    memset(&hints, 0, sizeof(hints));
    hints.ai_family = PF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;

    error = getaddrinfo("127.0.0.1", "2000", &hints, &res0);
    if (error) {
        errx(1, "%s", gai_strerror(error));
/*NOTREACHED*/
    }
    s = -1;
    for (res = res0; res; res = res->ai_next) {
        s = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
        if (s < 0) {
            warn("%s,", "socket");
            continue;
        }

        if (connect(s, res->ai_addr, res->ai_addrlen) < 0) {
            warn("%s", "connect");
            close(s);
            continue;
        } else {
            read(s, buffer, 50);
            printf("%s\n", buffer);
            close(s);
            break;
        }
    }
    freeaddrinfo(res0);
}
