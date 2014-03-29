#!/bin/sh

# $ ./87.sh a b c
# alice: a b c
# hat: a b c
# ./87.sh: a b c
# 3 arguments

echo "alice: $@"
echo "hat: $*"
echo "$0: $1 $2 $3 $4"
echo "$# arguments"

function alice
{
    echo "alice: $@"
    echo "$0: $1 $2 $3 $4"
    echo "$# arguments"
}

alice inn wonderland

# $ ./87.sh at home
# alice: at home
# hat: at home
# ./87.sh: at home
# 2 arguments
# alice: inn wonderland
# ./87.sh: inn wonderland
# 2 arguments
