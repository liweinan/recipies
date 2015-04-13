case class User(firstName: String, lastName: String, score: Int)

def advance(xs: List[User]) = xs match {
	case User(_, _, score1) :: User (_, _, score2) :: _ => score1 - score2
	case _ => 0
}

