import scala.io.Source

object LongLines {
    def processFile(filename: String, width: Int) = {

        def processLine(line: String) = {
            if (line.length > width)
                println(filename + ": " + line.trim)            
        }

        val source = Source.fromFile(filename)
        for (line <- source.getLines())
            processLine(line)
    }
}

object FindLongLines {
    def main(args: Array[String]) = {
        for (
            file <- new java.io.File(".").listFiles
            if file.getName.endsWith(".scala")
        )
            LongLines.processFile(file.getName, 55)
    }
}
