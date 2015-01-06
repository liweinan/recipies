#include <stdlib.h>
#include <stdio.h>

int main() {
    char *p;
    printf("%d\n", strtol("10ag", &p, 16));
    printf("%c\n", *p);
}