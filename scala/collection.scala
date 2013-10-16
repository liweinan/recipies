import scala.collection.mutable

val mutableSet = mutable.Set(1, 2, 3)
println(mutableSet.mkString(" "))

val poem = "My black face fades, hiding inside the black granite."
val words = mutable.Set.empty[String]
for (word <- poem.split("[ ,.]+"))
    words += word.toLowerCase

println(words) 

