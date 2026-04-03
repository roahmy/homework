source("PT4.R")

Solve <- function() {
  Task("Matrix65")              # 设置任务为 Matrix65
  
  M <- Get()                   # 读入矩阵行数 M
  N <- Get()                   # 读入矩阵列数 N
  Mat <- GetM(M, N)             # 读入 M x N 的矩阵数据
  
  # 题目要求：删除第一个仅包含正数的列
  # 逻辑：
  # 1. 遍历每一列，检查该列是否所有元素都大于 0
  # 2. 找到第一个满足条件的列索引
  # 3. 从矩阵中删除该列
  
  target_col <- 0               # 用于存储要删除的列号，0 表示未找到
  
  # 循环遍历每一列 (从 1 到 N)
  for (j in 1:N) {
    # 提取第 j 列
    current_col <- Mat[, j]
    # 检查该列是否所有元素都大于 0
    # all() 函数如果向量中所有元素为 TRUE 则返回 TRUE
    if (all(current_col > 0)) {
      target_col <- j           # 记录列号
      break                     # 找到第一个后立即跳出循环
    }
  }
  
  # 如果找到了符合条件的列 (target_col > 0)，则进行删除操作
  if (target_col > 0) {
    # R 语言中，Mat[, -k] 表示删除第 k 列
    # drop=FALSE 确保结果仍然是一个矩阵，即使只剩一列
    Mat <- Mat[, -target_col, drop = FALSE]
  }
  
  # 输出处理后的矩阵
  Put(Mat)
}

Start(Solve)