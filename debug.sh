function dbgtrap
{
    echo "badvar is $badvar"
}

function world
{
    badvar="world"
}

trap dbgtrap DEBUG
set -o functrace
badvar="Hello"
world
set +o functrace
trap - DEBUG
