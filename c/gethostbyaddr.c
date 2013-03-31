#include <arpa/inet.h>
#include <err.h>
#include <netdb.h>
#include <stdio.h>

int main() {
	const char *ipstr = "127.0.0.1";
	struct in_addr ip;
	struct hostent *hp;

	if (!inet_aton(ipstr, &ip))
		errx(1, "can't parse IP address %s", ipstr);

	if ((hp = gethostbyaddr((const void *)&ip, sizeof ip, AF_INET)) == NULL)
		errx(1, "no name associated with %s", ipstr);

	printf("name associated with %s is %s\n", ipstr, hp->h_name);
}