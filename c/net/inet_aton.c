#include <stdio.h>
#include <stdlib.h>
#include <arpa/inet.h>

int main() {
	struct in_addr addr;

	inet_aton("127.0.0.1", &addr);
	printf("%s\n", inet_ntoa(addr));
}
