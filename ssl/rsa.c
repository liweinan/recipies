#include "huge.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

// c = m ^ e % n
// this is replaced by mod_pow() in huge.c
void rsa_compute(huge *m, huge *e, huge *n, huge *c) {
	huge counter;
	huge one;
	
	copy_huge(c, m);
	set_huge(&counter, 1);
	set_huge(&one, 1);
	while (compare(&counter, e) < 0) {
		multiply(c, m);
		add(&counter, &one);		
	}
	
	divide(c, n, NULL);
	
	free_huge(&counter);
	free_huge(&one);
}

#ifdef RSA_MAIN
int main(void) {
	// 5^2 % 3 = 1
	// m = 5
	// e = 2
	// n = 3
	// c = 1	
	huge *m = malloc(sizeof(huge));
    huge *e = malloc(sizeof(huge));
    huge *n =  malloc(sizeof(huge));
    huge *c =  malloc(sizeof(huge));
    set_huge(m, 5);
    set_huge(e, 2);
    set_huge(n, 3);
    set_huge(c, 0);
	rsa_compute(m, e, n ,c);
	assert(strcmp("00000001", huge_to_binary(c))==0);
}
#endif