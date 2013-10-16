def incTemplate(more: Int) = (x: Int) => x + more

val inc = incTemplate(1)
println(inc(1))