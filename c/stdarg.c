/*
 * References:
 * http://www.cprogramming.com/tutorial/c/lesson17.html
 * http://cboard.cprogramming.com/c-programming/123850-minprintf.html
 * http://en.wikipedia.org/wiki/Phrases_from_The_Hitchhiker's_Guide_to_the_Galaxy
 * %man 3 stdarg
 */
 
/*
 * va_list
 * va_start()
 * va_arg()
 * va_end()
 */
#include <stdarg.h>
/*
 * printf()
 */
#include <stdio.h>
/*
 * putchar()
 */
#include <stdlib.h>

double average(int arg_number, ...);
void min_printf(char* fmt, ...);

int main() {
	double avg;
	printf("average: %f\n", average(3,1.2,2.4,3.3));
	min_printf("The %s is: %d\n", "ultimate answer of life", 42);
	return 0;
}

double average(int arg_number, ...) {
	/* 
	 * The name of the va_list object is not restricted. Use whatever name you like.
	 * We call it 'args' in this function.
	 */
	va_list args; 
	double sum = 0;
	int x;
	/* Initializing arguments to store all values after arg_number */
	va_start (args, arg_number);
	/* Sum all the inputs; we still rely on the function caller to tell us how
	 * many there are */
	for (x = 0; x < arg_number; x++) {
		sum += va_arg (args, double);
	}
	va_end (args); // Cleans up the list
	return sum / arg_number;
}

void min_printf(char *fmt, ...) {
	/* 
	 * The name of the va_list object is not restricted. Use whatever name you like.
	 * We call it 'ap' in this function.
	 */
	va_list ap;
	
	int ival;
	char *p;
	char *sval;
	
	va_start(ap, fmt);    /* make ap point to the first unnamed arg */

	for (p = fmt; *p; p++) {
		if (*p != '%') { /* just ordinary character, print it out */
			putchar(*p);
			continue;
		}
		
		/* We've found a control character, skip the '%', and then parse it. */
        switch (*++p) {
			case 'd':
				ival = va_arg(ap, int); /* get the int value from the variables */
				printf("%d", ival);
				break;
			case 's':
				for (sval = va_arg(ap, char*); *sval; sval++)
					putchar(*sval);
				break;
			default: /* don't know what the command means, just print it out. */
				putchar(*p);
				break;
		}
	}
	
	va_end(ap);
}