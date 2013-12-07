def triangle(n:Int) : Int = {
  if (n == 1)
    return 1
  else
    return(n + triangle(n-1))
}

println(triangle(3))

  
