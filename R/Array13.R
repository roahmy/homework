source("PT4.R")

Solve <- function() {
  Task("Array13")               # 设置任务为 Array13
  
  N <- Get()                    # 读入数组长度 N
  A <- GetV(N)                  # 读入数组 A（长度为 N）
  
  # 生成所有奇数位置的索引：1, 3, 5, ..., 不超过 N
  odd_positions <- seq(from = 1, to = N, by = 2)
  
  # 将这些位置的元素按从后往前的顺序取出
  result <- A[rev(odd_positions)]
  
  Put(result)                   # 输出结果
}

Start(Solve)