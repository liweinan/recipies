#include <stdio.h>
void func(int x[3]) { // argument address not equal to the address of first element of array
  printf("0x%x\n", (int) &x);
  printf("0x%x\n", (int) &x[0]);
  x[0] += 1;
}

void func2(int *y) {
  printf("0x%x\n", (int) &y);
  printf("0x%x\n", (int) &(y[0]));
}

int a[] = {1,2,3};

int main() {
  printf("0x%x\n", (int) &a);
  printf("0x%x\n", (int) &a[0]);
  int *p = a;
  printf("0x%x\n", (int) &p[0]); // address of first element
  printf("0x%x\n", (int) &p); // address of array
  func(a);
  func2(a);
  printf("%d\n", (int) a[0]);
  return 0;
}
