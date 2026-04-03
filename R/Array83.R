source("PT4.R")
Solve <- function() {
  Task("Array83")

  N <- Get()                # 读取数组长度
  A <- GetV(N)              # 读取 N 个实数
  
  # 执行右循环移位：
  # 将最后一个元素放到前面，其余元素右移
  result <- c(A[N], A[1:(N-1)])
  
  # 输出结果
  Put(result)
}


Start(Solve)
