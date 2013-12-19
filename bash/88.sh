#!/bin/sh
function afunc
{
	echo inn function: $0 $1 $2
	echo var1: $var1
	var1="changed by afunc"
	echo var1: $var1
}

var1="outside function"
echo var1: $var1
echo $0: $1 $2
afunc x y
echo back-home
echo var1: $var1

# $ ./88.sh at home
# var1: outside function
# ./88.sh: at home
# inn function: ./88.sh x y
# var1: outside function
# var1: changed by afunc
# back-home
# var1: changed by afunc