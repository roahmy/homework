from pt4 import *

def solve():
    task("Recur27")
    
    # 读取输入：N 和文件名
    N = get()          # 输入为整数
    filename = get()   # 输入为字符串
    
    with open(filename, 'w') as f:
        def backtrack(depth, a, b, path):
            if depth == N:
                if a == b:
                    f.write(f"C{path}\n")
                return
            
            remaining = N - depth
            # 剪枝条件：计算剩余层数是否能满足 a_total = b_total
            required_diff = b - a
            total_needed = remaining + required_diff
            if total_needed % 2 != 0:
                return
            added_a = total_needed // 2
            added_b = remaining - added_a
            if added_a < 0 or added_b < 0:
                return
            
            # 按字典序生成：先选A，再选B
            backtrack(depth + 1, a + 1, b, path + 'A')
            backtrack(depth + 1, a, b + 1, path + 'B')
        
        # 初始调用：深度0，A/B计数0，路径空
        backtrack(0, 0, 0, "")

start(solve)
