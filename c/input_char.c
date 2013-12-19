#include <stdio.h>

void input_name() {
   char input_char='\n';
   while(input_char == '\n') {
      scanf("%c", &input_char); // newline chars.
      printf("+ %c\n", input_char); 
   }
   while(input_char != '\n') {  // Loop until newline.
      scanf("%c", &input_char); // Get the next char.
      printf("> %c\n", input_char); 
   }
}

int main() {
	int (*ptr)();
	ptr = input_name;
	ptr();
	printf("%x\n", &input_name);
}


