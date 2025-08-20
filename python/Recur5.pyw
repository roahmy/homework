from pt4 import *

def solve():
    task("Recur5")
    
    # 初始化记忆数组（索引0不使用）
    memo = [0] * 21
    memo[1], memo[2] = 1, 1  # 基础情况
    
    def Fib2(N):
        if memo[N] != 0:     # 记忆化检查
            return memo[N]
        memo[N] = Fib2(N-2) + Fib2(N-1)  # 递归计算并缓存
        return memo[N]
    
    # 读取5个输入并输出结果
    for _ in range(5):
        N = get()       # 直接使用get()读取输入
        put(Fib2(N))    # 直接使用put()输出结果

start(solve)
