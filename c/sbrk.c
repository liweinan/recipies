#include <unistd.h>
#include <stdio.h>

int main(void) {
    printf("0x%x\n", sbrk(0));
    malloc(10000 * sizeof(int));
    printf("0x%x\n", sbrk(0));
}