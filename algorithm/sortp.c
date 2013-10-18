void sortPtr(void **ar, int n, int(*cmp)(const void *, const void *)) {
  int j;
  for (j=1; j<n; j++) {
    int i = j-1;
    void *value = ar[j];
    while (i>=0 && cmp(ar[i], value)>0) {
      ar[i+1] = ar[i];
      i--;
    }
    ar[i+1]=value;
  }
}

int main() {
  int **ptr;
  int arr[10];
  int *arrp[10];


  arr[0] = 1;
  arr[1] = 2;
  printf("arr[0]: %d, &arr[0]: %d\n", arr[0], &arr[0]);
  printf("arr[1]: %d, &arr[1]: %d\n", arr[1], &arr[1]);

  arrp[0] = &arr[0];
  arrp[1] = &arr[1];
  printf("*arrp[0]: %d, arrp[0]: %d\n", *arrp[0], arrp[0]);
  printf("*arrp[1]: %d, arrp[1]: %d\n", *arrp[1], arrp[1]);
  return 0;
}
