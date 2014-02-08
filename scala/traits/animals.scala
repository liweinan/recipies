class Animal
trait Furry extends Animal { def abc() = 1 }
trait HasLegs extends Animal
trait FourLegged extends HasLegs
class Cat extends Animal with Furry with FourLegged

class Hello {

	def sayHello() {
		val cat = new Cat
		cat.abc;
	}
}
		