val nums = List(1, 2, 3)
val fp = (x: Int) => print(x + " ")

nums.foreach(fp); println("")
nums.filter((x) => x > 1).foreach(fp); println("")
nums.filter(_ > 2).foreach(fp); println("")

val f = (_ : Int) + (_: Int)
print(f(5, 10) + " "); println("")