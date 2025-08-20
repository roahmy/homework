from pt4 import *
import collections

# 给定一棵非空树的根节点 A₁，对树中所有节点执行以下值转换操作：
# 1、​​叶节点处理​​：为每个叶节点（无子节点的节点）的值执行 +1 操作
# ​​2、内部节点处理​​：为每个内部节点（至少有一个子节点的节点）的值执行 -1 操作

def transform_tree(root: Node) -> None:
    
    # 对二叉树执行智能值转换：
    # - 叶节点（无子节点）：Data值 +1
    # - 内部节点（有子节点）：Data值 -1
    
    # 采用迭代式BFS遍历，时间复杂度O(n)，空间复杂度O(w)（w为树宽）
    # 优于递归方案，避免栈溢出风险
    
    if not root:
        return
    
    queue = collections.deque([root])
    
    while queue:
        node = queue.popleft()
        
        # 判断节点类型并执行相应操作
        if node.Left is None and node.Right is None:
            node.Data += 1  # 叶节点处理
        else:
            node.Data -= 1  # 内部节点处理
        
        # 添加有效子节点到队列
        if node.Left:
            queue.append(node.Left)
        if node.Right:
            queue.append(node.Right)


def solve():
    task("Tree37")

    A1 = get()

    try:
        values = transform_tree(A1)
        # put(f"前{N}个节点的值为: {values}")  # 输出: [1, 2, 3, 4]
        
    except ValueError as e:
        put(f"错误: {e}")   






start(solve)
