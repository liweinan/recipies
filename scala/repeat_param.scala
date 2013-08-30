def echo(args: String*) = for (arg <- args) println(arg)

echo("1", "2", "3", "4", "5")

val array = Array("Apple", "Pear", "Tomato")
echo(array: _*)