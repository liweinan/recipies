# Stop the script if any errors occur.
errhandler()
{
        errcode=$?
        echo "LINE $1: command exited with status $errcode."
        exit $errcode
}

trap 'errhandler $LINENO' ERR

archs=(5 6 7)

# el5.txt: copy paste from https://errata.devel.redhat.com/advisory/17043/builds
# el6.txt: https://errata.devel.redhat.com/advisory/17042/builds
# el7.txt: https://errata.devel.redhat.com/advisory/17368/builds
for arch in ${archs[@]}
do
    case "$arch" in
        5 ) tag_arch="dist-5E-ep-6.3-build" ;;
        6 ) tag_arch="jb-eap-6.3-rhel-6-build" ;;
        7 ) tag_arch="jb-eap-6.3-rhel-7-build" ;;
    esac    
    
    grep "^Brew Build" el${arch}.txt > el${arch}.out
    cat el${arch}.out | cut -d' ' -f 3 | sort > el${arch}.errata
    ./erratadiff.rb ${arch}
    el_list=$(cat el${arch}.list)
    brew latest-pkg ${tag_arch} $el_list > el${arch}.out 2>&1
    tail -n +3 el${arch}.out | sort | cut -d' ' -f1 > el${arch}.rpmdump
    diff -Nur el${arch}.errata el${arch}.rpmdump || true
done

