// When will the time_t's wrap around?

#include <stdio.h>
#include <time.h>

int main() {
	time_t biggest = 0x7FFFFFFF;
	printf("biggest = %s\n", ctime(&biggest));
	printf("biggest = %s \n", asctime(gmtime(&biggest)) );
}