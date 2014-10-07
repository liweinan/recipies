BEGIN {
    print srand();
}
END {
    print srand();
    print $0;
}