int main() {
  int p;
  int *i;
  int arr[5];
  arr[0] = 10;

  p = &arr[0];
  i = &arr[0];

  printf("*p: %d, *i: %d\n", **&(*&p), *i);
  return 0;
}
