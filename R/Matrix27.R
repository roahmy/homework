source("PT4.R")
Solve <- function() {
  Task("Matrix27")
  Task("Matrix23")
  M = Get()
  N = Get()
  A = GetM(M,N)
  
  Put(max(apply(A, 1, min)))
}


Start(Solve)