#!/bin/sh

sample="/tmp/sample.$$"

cat <<EOF > $sample
Jones
2143788477

Gondro
l2321565845

RinRao
2122383765
EOF

awkscript="/tmp/script$$.awk"

cat <<EOF > $awkscript
BEGIN {
    FS="\n";
    RS="\n\n";
}
{ print \$1, \$2; }
EOF

echo "gawk -f $awkscript < $sample"
gawk -f $awkscript < $sample

