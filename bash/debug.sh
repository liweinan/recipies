function dbgtrap
{
    echo "badvar is $badvar"
    echo "line: "$BASH_LINENO
    echo "source: "$BASH_SOURCE
}

function world
{
    badvar="world"
}

#set -o functrace
#trap dbgtrap DEBUG
badvar="Hello"
echo $badvar
world
#trap - DEBUG
#set +o functrace
echo $badvar
badvar=
