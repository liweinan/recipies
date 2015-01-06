BEGIN {
    FS=":";
    printf ("%20s %8s %8s %20s\n", "Name", "UserID", "GroupID", "HomeDirectory");
}
/^#+.*$/ { next; }
{ printf ("%20s %8s %8s %20s\n", $1, $3, $4, $6); }
END { print NR,"Records Processed"; }