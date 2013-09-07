// Using internal 'exists'
def isNegative(nums: List[Int]) = nums.exists(_ < 0)

println(isNegative(List(1, 2, -3, 4)))
println(isNegative(List(1, 2, 3, 4)))

// self-defined 'exists'
def myExists(lvals: List[Int], rval: Int, comparator: (Int, Int) => Boolean): Boolean = {
    for (lval <- lvals; if(comparator(lval, rval)))
        return true
    false
}

def isNegative2(nums: List[Int]) = myExists(nums, 0, _ < _)

println(isNegative2(List(1, 2, -3, 4)))
println(isNegative2(List(1, 2, 3, 4)))
