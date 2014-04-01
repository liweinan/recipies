_DIR='/tmp/use_automake'
mkdir -p ${_DIR}
pushd ${_DIR}

# Create automake file
touch Makefile.am
echo "SUBDIRS = ." > Makefile.am

# Create autoconf file
touch configure.ac
cat << EOF >> configure.ac
AC_CONFIG_FILES([Makefile])
EOF


popd
#rm -rf ${_DIR}
