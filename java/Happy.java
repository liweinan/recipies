/* 
 * javac Happy.java 
 * javah Happy
 * javah -stubs Happy
 */
class Happy {
	public native void printText();

	static {
		System.loadLibrary("happy");
	}
	
	public static void main (String[] args) {
		// System.loadLibrary("Happy");
		Happy happy = new Happy();
		happy.printText();
	}
}