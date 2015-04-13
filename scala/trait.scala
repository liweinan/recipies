trait User {
	def name: String
}

class FreeUser(val name: String) extends User
class PremiumUser(val name: String) extends User

object FreeUser {
	def unapply(user: FreeUser): Option[String] = Some(user.name)	
}

object PremiumUser {
	def unapply(user: PremiumUser): Option[String] = Some(user.name)
}


println(FreeUser.unapply(new FreeUser("Daniel")))

val user: User = new PremiumUser("Daniel")

user match {
	case FreeUser(name) => "free"
	case PremiumUser(name) => name
}