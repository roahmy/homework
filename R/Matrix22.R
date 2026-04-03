source("PT4.R")

Solve <- function() {
  Task("Matrix22")              # 设置任务为 Matrix22
  
  M <- Get()                   # 读入矩阵行数 M
  N <- Get()                   # 读入矩阵列数 N
  Mat <- GetM(M, N)             # 读入 M x N 的矩阵数据
  
  # 题目要求：计算偶数列 (2, 4, 6...) 的元素之和
  # 且 Do not use conditional statements (不使用 if 语句)
  
  # 1. 生成偶数列的索引序列：从 2 到 N，步长为 2
  even_cols <- seq(2, N, by = 2)
  
  # 2. 提取这些偶数列，并对每一列计算总和
  # apply(X, MARGIN, FUN): MARGIN=2 表示按列操作
  sums <- apply(Mat[, even_cols, drop = FALSE], 2, sum)
  
  # 3. 输出结果
  # 如果 sums 是向量，PutV 可以将其作为数组输出；如果是单个数，PutR 输出实数
  # 根据 PT 的习惯，这里通常输出一个实数序列
  Put(sums) 
}

Start(Solve)