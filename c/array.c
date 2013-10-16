#include <stdio.h>

int main(void) {
  int arr[2][2] = { 
    {1, 2},
    {3, 4}
  };
  int (*ptr_arr)[2]; // pointer to array
  ptr_arr = (int (*)[2]) &arr;
  int i, j;

  for (i=0; i<2; i++) {
    for (j=0; j<2; j++) {
      printf("arr[%d][%d]: %d; &[i]: %p; &[i+1]: %p; &[i][j]: %p\n", 
        i, j, ptr_arr[i][j], &ptr_arr[i], &ptr_arr[i+1], 
        &ptr_arr[i][j]);
    }
  }

  // array of pointer
  int *ptr[2];

  ptr[0] = &arr[0][0];
  ptr[1] = &arr[1][1];
  printf("ptr[1]: %d; ptr[2]: %d\n", *ptr[0], *ptr[1]);

  // hack
  int (*hack_ptr_arr)[3];
  hack_ptr_arr = (int (*)[3]) &arr;  

  printf("arr[%d][%d]: %d\n", 0, 0, hack_ptr_arr[0][0]);
  printf("arr[%d][%d]: %d\n", 0, 1, hack_ptr_arr[0][1]);
  printf("arr[%d][%d]: %d\n", 0, 2, hack_ptr_arr[0][2]);
  printf("arr[%d][%d]: %d\n", 1, 0, hack_ptr_arr[1][0]);

}