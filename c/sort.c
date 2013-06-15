#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAXLINES 5000     /* max #lines to be sorted */
#define MAXLEN 1000 

char *lineptr[MAXLINES];  /* pointers to text lines */

int readlines(char *lineptr[], int nlines);
void writelines(char *lineptr[], int nlines);

void q_sort(char *lineptr[], int left, int right);
int get_line(char *, int);


/* sort input lines */
int main()
{
   int nlines;     /* number of input lines read */

   if ((nlines = readlines(lineptr, MAXLINES)) >= 0) {
	   q_sort(lineptr, 0, nlines-1);
	   writelines(lineptr, nlines);
	   return 0;
   } else {
	   printf("error: input too big to sort\n");
	   return 1;
   }
}

/* readlines:  read input lines */
int readlines(char *lineptr[], int maxlines)
{
   int len, nlines;
   char *p, line[MAXLEN];

   nlines = 0;
   while ((len = get_line(line, MAXLEN)) > 0)
	   if (nlines >= maxlines || (p = malloc(len)) == NULL)
		   return -1;
	   else {
		   line[len-1] = '\0';  /* delete newline */
		   strcpy(p, line);
		   lineptr[nlines++] = p;
	   }
   return nlines;
}

/* writelines:  write output lines */
void writelines(char *lineptr[], int nlines)
{
   int i;

   for (i = 0; i < nlines; i++)
	   printf("%s\n", lineptr[i]);
}

/* q_sort:  sort v[left]...v[right] into increasing order */
void q_sort(char *v[], int left, int right)
{
   int i, last;
   void swap(char *v[], int i, int j);

   if (left >= right)  /* do nothing if array contains */
	   return;         /* fewer than two elements */
   swap(v, left, (left + right)/2);
   last = left;
   for (i = left+1; i <= right; i++)
	   if (strcmp(v[i], v[left]) < 0)
		   swap(v, ++last, i);
   swap(v, left, last);
   q_sort(v, left, last-1);
   q_sort(v, last+1, right);
}

 /* swap:  interchange v[i] and v[j] */
void swap(char *v[], int i, int j)
{
   char *temp;

   temp = v[i];
   v[i] = v[j];
   v[j] = temp;
}

/* get_line:  read a line into s, return length  */
int get_line(char *s,int lim)
{
   int c, i;

   for (i= 0; i < lim-1 &&(c=getchar())!=EOF && c!='\n'; ++i)
	   s[i] = c;
   if (c == '\n') {
	   s[i] = c;
	   ++i;
   }
   s[i] = '\0';
   return i;
}