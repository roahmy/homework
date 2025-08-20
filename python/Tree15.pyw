from pt4 import *

from typing import List, Optional

def get_first_n_values(root: Node, n: int) -> list:
    
    # 获取中序遍历前N个节点的值
    
    # 参数:
    #     root: 树的根节点
    #     n: 需要获取的节点数量（1 ≤ N ≤ 节点总数）
    
    # 返回:
    #     前N个节点的值列表（按中序顺序）
    
    # 算法说明:
    #     1. 使用迭代法中序遍历二叉树
    #     2. 遍历时对节点从1开始编号
    #     3. 收集编号≤N的节点值
    #     4. 当编号>N时提前终止遍历
    
    if n <= 0:
        raise ValueError("N必须为正整数")
    
    result = []  # 存储结果
    stack = []   # 辅助栈
    current = root
    count = 0    # 节点计数器
    
    while current or stack:
        # 遍历到最左侧节点
        while current:
            stack.append(current)
            current = current.Left
        
        # 处理当前节点
        current = stack.pop()
        count += 1  # 节点编号+1
        
        # 收集编号≤N的节点值
        if count <= n:
            result.append(current.Data)
        else:
            break  # 提前终止遍历
        
        # 处理右子树
        current = current.Right
    
    if count < n:
        raise ValueError(f"树只有{count}个节点，小于指定的N={n}")
    
    return result


def solve():
    task("Tree15")

    A1, N = get2()

    try:
        values = get_first_n_values(A1, N)
        # put(f"前{N}个节点的值为: {values}")  # 输出: [1, 2, 3, 4]
        put(values)
    except ValueError as e:
        put(f"错误: {e}")


start(solve)
