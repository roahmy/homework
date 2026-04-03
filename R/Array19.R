source("PT4.R")
Solve <- function() {
  Task("Array19")
  
  # 读取 10 个整数数组
  A <- GetV(10)
  
  # 获取首尾两个元素
  A1 <- A[1]                # 第一个元素
  A10 <- A[10]              # 最后一个元素
  
  # 初始化结果为 0（表示未找到）
  result <- 0
  
  # 从后往前遍历数组（找“最后”一个满足条件的）
  for (k in 10:1) {
    if (A1 < A[k] && A[k] < A10) {
      result <- k             # 记录位置
      break                   # 找到就退出
    }
  }
  
  # ⚠️ 关键：将 result 转换为整数类型，避免类型错误
  Put(as.integer(result))
}


Start(Solve)
