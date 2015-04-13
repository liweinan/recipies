abstract class Expr
case class BinOp (op:String, left:Expr, right:Expr) extends Expr
case class Number (number:Int) extends Expr

def eval(e:Expr) : Int = e match {
	case Number(n) => n
	case BinOp(o, l, r) => evalOp(o, eval(l), eval(r))
}

def evalOp(o:String, l:Int, r:Int) : Int = o match {
	case "*" => l * r
	case "-" => l - r
	case "+" => l + r
}


