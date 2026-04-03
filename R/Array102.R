source("PT4.R")
Solve <- function() {
  Task("Array102")

  A = GetV()
  K = Get() 
  A = append(A, 0, after = K)
  Put(A)
}


Start(Solve)
