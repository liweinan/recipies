void sortPtr(void **ar, int n, int (*cmp)(const void *, const void *)) {
  int j;
  for (j=1; j<n; j++) {
    int i = j-1;
    void *value = ar[j];
    while (i >= 0 && cmp(ar[i], value) > 0) {
      ar[i+1] = ar[i];
      i--;
    }
    ar[i+1]=value;
  }
}

int ab_cmp(const void *a, const void *b) {
  if (a > b) {
    return 1;
  }
  return 0;
}

int main() {

  int a[10] = {10, 9, 8, 7, 6, 5, 4, 3, 2, 1};
  sortPtr(&a, 10, ab_cmp);

  return 0;
}
