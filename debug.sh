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

set -o functrace
trap dbgtrap DEBUG
badvar="Hello"
world
trap - DEBUG
set +o functrace
badvar=
