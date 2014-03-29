abstract class AbsCell {
  type T
  val init: T
  private var value: T = init // initial value
  def get: T = value;
  def set(x: T): Unit = { value = x }
  def reset : Unit = { value = init }
}

val cell = new AbsCell { type T = Int; val init = 1 }
cell.set(10)
println(cell.get)
cell.reset
println(cell.get)
