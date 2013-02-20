#!/usr/bin/perl
#
# purpose: this is a perl program that demonstrates
#          how to read file contents from STDIN (perl stdin),
#          use the perl split function to split each line in 
#          the file into a list of words, and then print each word.
#
# usage:   perl this-program.pl < input-file
$global_count = 0;
$count = 0;
# read from perl stdin
while (<>)
{
  # split each input line; words are separated by whitespace
  for $word (split)
  {
    $global_count += 1;
    if ($global_count <= 2)
    {
	next;
    } 
    $count += 1;
    # do whatever you need to here. in my case
    # i'm just printing each "word" on a new line.
  
    print $word;

    if ($count == 3) 
    {
	print "\n";
        $count = 0;
    }
    else
    {
	print " ";
    }
  }
}
