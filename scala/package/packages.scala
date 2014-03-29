package a {
	package b {
		class Apple
		
		package c {
			class Pear
		}
	}
}

package d {
	class Tomato {
		import a.b.{Apple => PineApple}
		val pineApple = new PineApple
	}
}
		