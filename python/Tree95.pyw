from pt4 import *
import sys

sys.setrecursionlimit(10000)  # 增加递归深度限制

# 给定非空广义树的根节点引用 A₁。需执行以下操作：
# 1、​​执行中序遍历​​：按照 Tree92 规范实现树的中序遍历算法
# ​​2、定位目标节点​​：找到第一个具有最大子节点数的节点
# ​​3、返回引用​​：输出该节点的引用 A₂

def find_first_max_children_node(root):
    # 定位第一个具有最大子节点数的节点(中序遍历顺序)
    if root is None:
        return None
    
    max_node = None
    max_count = -1
    
    # 中序遍历中检查每个节点
    stack = []
    current = root
    
    while stack or current:
        if current:
            # 先深入左子树（第一个孩子）
            stack.append(current)
            current = current.Left
        else:
            # 处理当前节点
            current = stack.pop()
            
            # 计算当前节点的子节点数
            count = 0
            child = current.Left
            while child:
                count += 1
                child = child.Right  # 遍历所有直接右兄弟
            
            # 更新第一个遇到的最大子节点数节点
            if count > max_count:
                max_count = count
                max_node = current
            
            # 转向右兄弟
            current = current.Right
    
    return max_node

def solve():
    task("Tree95")

    A1 = get()

    try:
        # 查找目标节点
        A2 = find_first_max_children_node(A1)
        put(A2)
        
    except ValueError as e:
        put(f"错误: {e}")   


start(solve)
