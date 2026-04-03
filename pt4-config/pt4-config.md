# 一、PT4 注册及使用
- 1.老师会给每一个人有一个类似身份信息的文件：access.dat，与每个人对应；
- 2.把access.dat 放到准备存放作业源代码目录的文件夹（最好新建的空文件夹）下面；
- 3.打开pt4 panel 程序，下拉框选择准备存放作业的文件夹；
- 4.在panel最右边的两个按钮中，选择第1个，弹出注册框，
  - 4.1 第一个界面不用管，直接NEXT，第二个界面也直接NEXT；
  - 4.2 在界面：Working directories setup 界面的：File access.dat 界面后，选择按钮：Add [F10] ，选择获得的access.dat，完成注册；
- 5.完成注册后，在panel 左边按钮选择第三个：Load， 则可以看到自己的作业题；

# 二、PT4中使用RStudio作为编辑器时要注意的点：
- 要使用PT4的方法进行输入、输出，不能使用原本R语言的方法，会导致不能与PT4进行数据通信，也就不能获得题目中自动给出的测试用例。
- 如下面代码中的Get(), GetV(), Put() 等是PT4的写法，非标准R语言库。
```R
source("PT4.R")

Solve <- function() {
  Task("Array83")           # 设置任务编号
  
  N <- Get()                # 读取数组长度
  A <- GetV(N)              # 读取 N 个实数
  
  # 执行右循环移位：
  # 将最后一个元素放到前面，其余元素右移
  result <- c(A[N], A[1:(N-1)])
  
  # 输出结果
  Put(result)
}

Start(Solve)
```
