mypushd()
{
	dirname=$1
	DIR_STACK="$dirname ${DIR_STACK:=$PWD' '}"
	cd ${dirname:?"missing directory name."}
	echo "$DIR_STACK"
}

mypopd()
{
	DIR_STACK=${DIR_STACK#* }
	cd ${DIR_STACK%% *}
	echo "$PWD"
}

mypushd sandbox
 
mypopd
