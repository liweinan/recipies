#include <stdio.h>

int main() {
  printf("%x %x %x %x\n", 'c', 'a', 'f', 'e');
  
  union {
  	int whole;
  	char bytes[4];
  } b;

  b.whole = 0x63616665;
  
  for (int i = 0; i < 4; i++) {    
  	printf("%c ", b.bytes[i]);
  }
  
  printf("\n");  
  
  b.bytes[0] = 'c';
  b.bytes[1] = 'a';
  b.bytes[2] = 'f';
  b.bytes[3] = 'e';
  
  printf("0x%x\n", b.whole);
}
