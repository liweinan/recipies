#include <stdio.h>

int array_pass(int *arr);
int pass_by_address(int *ptr);
int pass_by_value(int val);

int main() {
	int arr[2];
	arr[0] = 1;
	arr[1] = 2;
	
	// The results of two lines in below should be the same.
	printf("arr[0]: %d\n", (int) &arr[0]); // Print the start address of arr[]
	printf("array_pass: %d\n", array_pass(arr)); // The first address will be passed to array_pass.
	
	int val_a = 1;
	int *ptr1 = &val_a;	
	printf("&val_a: %d\n", (int) &val_a);
	printf("pass_by_address(ptr1): %d\n", 	pass_by_address(ptr1));
	printf("pass_by_value(*ptr1): %d\n", 	pass_by_value(*ptr1));
	// incorrect usages
	printf("pass_by_address(ptr1): %d\n", 	pass_by_address((*ptr1));
	printf("pass_by_value(*ptr1): %d\n", 	pass_by_value(ptr1));
	
}

int array_pass(int *arr) {
	return (int) arr;
}

int pass_by_address(int *ptr) { // the parameter passed in will be treated as address
	return (int) ptr;
}

int pass_by_value(int val) { // the parameter passed in will be treated as value
	return val;
}