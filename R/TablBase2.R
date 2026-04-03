source("PT4.R")
Solve <- function() {
  Task("TablBase2")
  # d = GetCountries()
  # cap = Get()
  # Show(d)
  # Use the Put(table) function to output the contents of the table
  # (table must be of type data.frame and contain country information)

  # 1. 获取国家数据表
  d <- GetCountries()
  
  # 2. 读取输入的首都名称 (字符串)
  # 题目描述中变量名为 Cap，这里保持一致
  Cap <- Get()
  
  # 3. 筛选数据
  # 在数据框 d 中，找到 Capital 列等于 Cap 的那一行
  # 注意：PT4 的数据库任务通常列名是固定的，Capital 代表首都
  result <- d[d$Capital == Cap, ]
  
  # 4. 输出结果
  Put(result)
  
}


Start(Solve)
