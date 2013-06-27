// http://www.java2s.com/Code/C/File/Writingafileacharacteratatime.htm

#include <stdio.h>
#include <string.h>

int main()
{
   char mystr[80]="abc";
   int i = 0;
   int lstr = 0;
   int mychar = 0;
   FILE *pfile = NULL;
   char *filename = "/tmp/my_char";

   pfile = fopen(filename, "w");
   if(pfile == NULL)
   {
     printf("Error opening %s for writing. Program terminated.", filename);
   }

   lstr = strlen(mystr);
   for(i = lstr-1 ; i >= 0 ; i--)
     fputc(mystr[i], pfile);  /* Write string to file backwards */

   fclose(pfile);

}