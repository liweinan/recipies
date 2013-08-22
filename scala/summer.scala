import ChecksumAccumulator.calculate

object Summer {
    def main(args: Array[String]) = {
        val checksum = new ChecksumAccumulator()
        for (i <- 1 to 10) {
            checksum.add(1)
            println(checksum.checksum)
        }

        for (arg <- args)
            println(arg + ": " + calculate(arg))
    }
}