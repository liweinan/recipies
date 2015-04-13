object extractor {
	def unapply(foo: Foo): Boolean = foo.key > 1
}

class Foo(val key: Int)

val foo: Foo = new Foo(2)

foo match {
	case foo @ extractor => println("valid key")
	case _ => println("invalid")
}