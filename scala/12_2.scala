trait Philosophical {
    def philosophize() {
        println("I consume memory, therfore I am!")
    }
}

class Frog extends Philosophical {
    override def toString = "green"
}

val frog = new Frog
frog.philosophize()
val phil : Philosophical = frog
phil.philosophize()

class Animal
class Frog2 extends Animal with Philosophical {
    override def toString = {
        "green2"
    }
}

val frog2 = new Frog2
println(frog2.toString())

trait HasLegs {
    def legs = {
        println("4 legs!")
    }
}

class Frog3 extends Animal with Philosophical with HasLegs {
    override def toString = "green3"
}

val frog3 = new Frog3
frog3.legs

