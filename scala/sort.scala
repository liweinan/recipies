trait MyComparable[T] {
	def compareTo(that : T) : Int
}

abstract class BaseSort {
	def sayHello = {
		println("Hello, world!")
	}
}

class SelectionSort extends BaseSort {
	
}

val selectionSort = new SelectionSort
selectionSort.sayHello

class Apple with MyComparable