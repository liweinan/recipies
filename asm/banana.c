#include <stdio.h>

int main(void) {
  int a=10, b;
  asm ("movl %1, %%eax;movl %%eax, %0;"
        :"=r"(b)
        :"r"(a)
        :"%eax"
        );
  asm("nop");
  
  int res=0;
  int op1=20;
  int op2=30;

  asm("mov %0, %1;"
      :"=r"(res)
      :"r"(op1)
      :"%eax");
  asm("nop");
  printf("%d",b);
  return 0;
}
