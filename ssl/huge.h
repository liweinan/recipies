#ifndef __SSL_HUGE
#define __SSL_HUGE
typedef struct {
    unsigned int size;
    unsigned char *rep;
} huge;
const char* byte_to_binary(int x);
const int binary_to_byte(char* x);
void print_huge(huge *h);
char* huge_to_binary(huge *h);
int compare(huge *h1, huge *h2);
void add(huge *h1, huge *h2);
void divide(huge *dividend, huge *divisor, huge *quotient);
void multiply(huge *h1, huge *h2);
void subtract(huge *h1, huge *h2);
void mod_pow(huge *m, huge *exp, huge *n, huge *c);
void set_huge(huge *h, unsigned int val);
void copy_huge(huge *tgt, huge *src);
void free_huge(huge *h);
#endif
