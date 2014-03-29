trait Rectangular {
      def topLeft: Point
      def bottomRight: Point

      def left = topLeft.x
      def right = bottomRight.x
      def width = right - left
}

class Point(val x:Integer, val y:Integer) {}

class Rectangle(val topLeft: Point, val bottomRight: Point) extends Rectangular {
}

val rect = new Rectangle(new Point(1,1), new Point(10,10))

println(rect.left)