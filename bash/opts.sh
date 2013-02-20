#sh ./opts.sh -a -b x -c 1 2 3
#opt-a
#opt-b
#$OPTARG: x
#opt-c
#args: 1 2 3
while getopts ":ab:c" opt; do
	case $opt in
		a ) echo 'opt-a';;
		b ) echo 'opt-b'
			echo '$OPTARG: '"$OPTARG";;
		c ) echo 'opt-c';;
		\? ) echo "usage: $0 [-a] [-b arg] [-c] args..."
			exit 1
	esac
done

shift $(($OPTIND - 1))

echo "args: $*"

