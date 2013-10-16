#include <stdio.h>

#define SWAP(a, b) {int temp; temp=a; a=b; b=temp;}

void quick_sort_sub(int *data, int left, int right) {
	int left_idx = left;
	int right_idx = right;
	int pivot = data[(left + right) / 2];
	
	while (left_idx <= right_idx) {
		for (; data[left_idx] < pivot; left_idx++) {
			for (; data[right_idx] > pivot; right_idx--) {
				if (left_idx <= right_idx) {
					SWAP(data[left_idx], data[right_idx]);
					left_idx++;
					right_idx--;
				}
			}
		}
	}
	
	if (right_idx > left) {
		quick_sort_sub(data, left, right_idx);
	}
	
	if (left_idx < right) {
		quick_sort_sub(data, left_idx, right);
	}
}

void quick_sort(int *data, int data_size) {
	quick_sort_sub(data, 0, data_size - 1);
}

int main(void) {
	int i = 0;
	int arr[] = {9, 8, 7, 6, 5, 4, 3, 2, 1, 0};
	 
	quick_sort(arr, 10);
	
	for (i=0; i<10; i++) {
		printf("%d ", arr[i]);
	}
	
	return 0;
}
