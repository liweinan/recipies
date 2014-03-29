#!/bin/sh
rm -rf Makefile config.h config.h.in config.status configure configure.ac config.log \
autoscan.log autom4te.cache
autoscan
mv configure.scan configure.ac
./autogen.sh
./configure
make
