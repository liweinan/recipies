#include <stdio.h>
// before running, try:
// $ export LISTENQ=example
int main() {
	printf("LISTENQ: %s\n", getenv("LISTENQ"));
}
