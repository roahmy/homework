source("PT4.R")
Solve <- function() {
  Task("Array80")
  N = Get()
  A = GetV(N)
  
  Put(c(A[-1], 0))
}


Start(Solve)
