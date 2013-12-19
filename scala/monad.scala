trait Monad[A] {
      def map[B](f: A => B): Monad[B]
}