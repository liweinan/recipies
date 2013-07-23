#include <stdio.h>
#include <string.h>

void write_str_to_file(char* str, char* filename) {
   int i = 0;
   int len = 0;
   FILE *pfile = NULL;

   pfile = fopen(filename, "w");
   if(pfile == NULL) {
     printf("Error opening %s for writing. Program terminated.", filename);
   }

   len = strlen(str);
   fwrite(str, sizeof(char), len, pfile);

   fclose(pfile);

}