def fileLines(file: java.io.File) =
    scala.io.Source.fromFile(file).getLines.toList

def grep(pattern: String) = 
    for {
        file <- new java.io.File(".").listFiles 
        if file.getName.endsWith(".scala")
        line <- fileLines(file)
        trimmed = line.trim
        if trimmed.matches(pattern)
    } println(file + ": " + trimmed)

grep(".*for.*")

println("*********")

def scalaFiles = 
    for {
        file <- new java.io.File(".").listFiles 
        if file.getName.endsWith(".scala")
    } yield file

for (file <- scalaFiles)
    println(file)

