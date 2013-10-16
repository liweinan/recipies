#include <stdio.h>


int main() {
	int i;
	int arr[3];
	arr[0] = 0;
	arr[1] = 1;
	arr[2] = 2;
	
	int (*arr_ptr)[3];
	
	arr_ptr = &arr; // arr_ptr = arr also work
	printf("arr: %p; arr_ptr: %p\n", arr, arr_ptr);
	for (i = 0; i < 3; i++) {
		printf("arr[%d]: %d; arr_ptr[%d]: %d\n", i, arr[i], i, (*arr_ptr)[i]);
	}
}