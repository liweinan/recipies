package a
package b {
	private[a] class Apple {
		protected[b] def abc() = 0
		class Core {
			private[Apple] val color = "Black"
		}
		private[this] var size = 1
	}	
}