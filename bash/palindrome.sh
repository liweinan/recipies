#!/bin/sh

function is_palindrome {
    testit="$(echo $@ | sed 's/[^[:alpha:]]//g' | tr '[:upper:]' '[:lower:]')"
    backwards="$(echo $testit | rev)"

    if [ "$testit" = "$backwards" ]; then
        echo "$@ is a palindrome"
    else
        echo "$@ is not a palindrome"
    fi
}

is_palindrome Hello
is_palindrome Ada