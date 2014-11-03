#include <stdio.h>

int main(int argc, char* argv[]) {
    for (int i = 0; i < argc; i++) {
        printf("%x %c %s\n", argv[i], *argv[i], argv[i]);
    }
}