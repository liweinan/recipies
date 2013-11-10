def binarySearch(key : Int, a : List[Int]) : (Int, Int) = {
  var lo : Int = 0
  var hi : Int = a.length - 1
  var mid : Int = 0
  while (lo <= hi) {
    mid = lo + (hi - lo) / 2
    if (key < a(mid)) hi = mid - 1
    else if (key > a(mid)) lo = mid + 1
    else return (key, mid)
  }
  (-1, -1)
}

// no var
// more memory consumption
def binarySearchRecursive(key : Int, a : List[Int], lo : Int, hi : Int) : (Int, Int) = {
  if (lo <= hi) {
    val mid = lo + (hi - lo) / 2
    if (key < a(mid)) return binarySearchRecursive(key, a, lo, mid-1)
    else if (key > a(mid)) return binarySearchRecursive(key, a, mid+1, hi)
    else return (key, mid)
  }
  (-1, -1)
}

val result = binarySearch(3, List(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
println(result)
val list = List(1,2,3,4,5)
val result2 = binarySearchRecursive(4, list, 0, list.length)
println(result2)
