def filesMatching(query: String, matcher: (String, String) => Boolean) = {
    for (file <- (new java.io.File(".").listFiles)
        if matcher(file.getName, query))
        yield file
}

for (file <- filesMatching("scala", _.endsWith(_)))
    print(file + " ")