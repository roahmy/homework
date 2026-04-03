source("PT4.R")

Solve <- function() {
  Task("Matrix55")              # 设置任务为 Matrix55
  
  M <- Get()                   # 读入矩阵行数 M
  N <- Get()                   # 读入矩阵列数 N
  Mat <- GetM(M, N)             # 读入 M x N 的矩阵数据
  
  # 题目要求：交换矩阵的上半部分和下半部分
  # M 是偶数，所以上半部分是 1 到 M/2 行，下半部分是 (M/2 + 1) 到 M 行
  
  half <- M / 2
  
  # 构造新的矩阵顺序：
  # 先取下半部分的行：(half + 1):M
  # 再取上半部分的行：1:half
  # 保持所有列不变
  NewMat <- Mat[c((half + 1):M, 1:half), ]
  
  # 输出修改后的矩阵
  Put(NewMat)
}

Start(Solve)