object Email extends ((String, String) => String) {

	def apply(user: String, domain: String): String = user + "@" + domain
	
	def unapply(str: String): Option[(String, String)] = {
		var parts = str split "@"
		if (parts.length == 2) Some(parts(0), parts(1)) else None	
	}

}

object Twice {
	def apply(s: String): String = s + s
	def unapply(s: String): Option[String] = {
		val length = s.length / 2
		val half = s.substring(0, length)
		if (half == s.substring(length)) Some(half) else None
	}
}

object PlayGround {	
	def main(args: Array[String]) = {
		val str = "l.weinan@gmail.com"
		str match {
			case Email(user, domain) => println(user + " AT " + domain)
			case _ => println("Not a valid email address")
		}

		val doubleName = "weliweli@redhat.com"
		doubleName match {
			case Email(Twice(singleName), domain) => println(singleName + " AT " + domain)
			case _ => println("Not a valid email address with double user name")
		}
	}
}

PlayGround.main(null)