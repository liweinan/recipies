#!/bin/bash
vars=(a b c)

while getopts ":a" opt "${vars[@]}"; do
    case $opt in
        a)
            echo "-a was triggered!" >&2
            ;;
        \?)
            echo "Invalid option: -$OPTARG $opt" >&2
            ;;
    esac
done