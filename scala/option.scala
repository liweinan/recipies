object Test {
	def main(args: Array[String]) {
		val capitals = Map("France" -> "Paris", "Japan" -> "Tokyo")
		println(show(capitals.get("Japan")))
		println(show(capitals.get("India")))
	}
	
	def show(x: Option[String]) = x match {
		case Some(s) => s
		case None => "?"
	}
}