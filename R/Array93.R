source("PT4.R")
Solve <- function() {
  Task("Array93")

  N = Get()
  A = GetV(N)
  
  Put(A[seq(1, length(A), by = 2)])
}


Start(Solve)
