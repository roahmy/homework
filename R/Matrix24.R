source("PT4.R")

Solve <- function() {
  Task("Matrix24")              # 设置任务为 Matrix24 (注意这里改为了截图中的 Matrix24)
  
  M <- Get()                   # 读入矩阵行数 M (使用 GetN 读取整数)
  N <- Get()                   # 读入矩阵列数 N
  Mat <- GetM(M, N)             # 读入 M x N 的矩阵数据
  
  # 题目要求：找出每一列的最大元素
  # 逻辑：我们需要对矩阵的每一列应用 max() 函数
  
  # apply(X, MARGIN, FUN) 是 R 语言中非常强大的函数
  # X: 数据矩阵
  # MARGIN: 1 表示按行，2 表示按列。这里我们需要按列操作，所以填 2
  # FUN: 要应用的函数，这里是 max (最大值)
  
  max_elements <- apply(Mat, 2, max)
  
  # 输出结果
  # max_elements 是一个包含每列最大值的向量
  Put(max_elements)            # 使用 PutV 输出实数向量
}

Start(Solve)