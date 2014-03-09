class Animal {
	def name = "Animal"
}

trait Furry extends Animal {
	override def name = "Furry"
}

trait HasLegs extends Animal {
	override def name = "HasLegs"
}

trait FourLegged extends Animal {
	override def name = "FourLegged"
}

class Cat extends Animal with Furry with FourLegged

class Cat2 extends Animal with FourLegged with Furry

val cat = new Cat
println(cat.name)

val cat2 = new Cat
println(cat2.name)
