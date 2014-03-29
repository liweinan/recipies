object FavoriteFruit {
	def get(fruitName : String)(implicit fruitColor : String) {
		println(s"I love $fruitColor $fruitName")
	}
}

object FavoriteFruitColor {
	implicit val color = "Red"
}


object Main {
	import FavoriteFruitColor._
	
    def main(args: Array[String]) {
		FavoriteFruit.get("Apple")
		FavoriteFruit.get("Apple")("Yellow")
    }
}

//Main.main(args)
  


