#!/bin/sh

cleanup ()
{
	echo "Cleanup..."
	rm -rf Makefile config.h config.h.in config.status configure configure.ac config.log \
		autoscan.log autom4te.cache install-sh configure.ace
}

buildit ()
{
	echo "Building..."
	autoscan
	mv configure.scan configure.ac
	sed -ie s/FULL-PACKAGE-NAME/Jupiter/ configure.ac
	sed -ie s/VERSION/1.0/ configure.ac
	sed -ie s/BUG-REPORT-ADDRESS/bug@example.com/ configure.ac

	./autogen.sh
	./configure
	make
}

while getopts ":cb" opt; do
	case $opt in
		c	) cleanup 
			exit 0;;
		b	) cleanup
			buildit
			exit 0 ;;
		\?	) echo 'Usage: build.sh [-c] [-b]'
			exit 1 
	esac
done

echo 'Usage: build.sh [-c] [-b]'
