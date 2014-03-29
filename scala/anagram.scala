var arr = Array('a', 'b', 'c', 'd')

def anagram(size : Int) : Unit = {
	if (size > 1) {
		for (i <- 1 to size) {
			anagram(size - 1)
			print(size+"-"+i+": ")
			//if (size == 2)
				printArray
			rotate(size)
		}
	}
}


def rotate(size : Int) : Unit = {
	val pos = arr.length - size
	val left = arr.slice(0, pos)
	val tmp = arr(pos)
	val right = arr.slice(pos+1, arr.length)
	arr = left ++ right ++ Array(tmp)
}

def	printArray = {
	for (s <- arr) {
		print(s)
	}
	println("")
}


anagram(arr.length)