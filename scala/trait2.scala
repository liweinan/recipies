trait User {
	def name: String
	def score: Int
}

class FreeUser(val name: String, val score: Int, val upgradeProbability: Double) extends User
class PremiumUser(val name: String, val score: Int) extends User

object FreeUser {
	def unapply(user: FreeUser): Option[(String, Int, Double)] =
	Some((user.name, user.score, user.upgradeProbability))
}

object PremiumUser {
	def unapply(user: PremiumUser): Option[(String, Int)] = Some((user.name, user.score))
}

val user: User = new FreeUser("Tom", 3000, 0.7d)
user match {
	case FreeUser(name, _, p) => if (p > 0.5) println("passed") else println("failed")
	case PremiumUser(name, _) => println("foo")
}
