from pt4 import *
import collections

# 给定一棵非空树的根节点 A₁。对于树中每个​​只有一个子节点​​的节点，添加另一个子节点（作为叶子节点）。
# 所创建的子节点的值应等于其父节点值的两倍。

def expand_single_child_nodes(root: Node) -> None:
    
    # 遍历树结构并扩展单一子节点的节点
    # 算法特点：
    #  1. 使用BFS迭代避免递归深度限制
    #  2. 时间复杂度O(n) - 每个节点只访问一次
    #  3. 空间复杂度O(w) - w为树的最大宽度
    
    if not root:
        return
    
    # 使用双端队列进行BFS遍历
    queue = collections.deque([root])
    
    while queue:
        current = queue.popleft()
        
        # 检查节点子节点数量
        has_left = current.Left is not None
        has_right = current.Right is not None
        
        # 情况1：只包含左子节点
        if has_left and not has_right:
            # 创建新右子节点（父节点值的2倍）
            new_node = AddNode(current.Data * 2)
            current.Right = new_node
            # print(f"节点 {current.Data} 添加右子节点: {new_node.Data}")
        
        # 情况2：只包含右子节点
        elif has_right and not has_left:
            # 创建新左子节点（父节点值的2倍）
            new_node = AddNode(current.Data * 2)
            current.Left = new_node
            # print(f"节点 {current.Data} 添加左子节点: {new_node.Data}")
        
        # 将有效子节点加入队列（包括刚创建的新节点）
        if current.Left:
            queue.append(current.Left)
        if current.Right:
            queue.append(current.Right)

def AddNode(d):
    p1 = Node()
    p1.Data = d
    p1.Left = p1.Right = None
    return p1
    

def solve():
    task("Tree46")

    A1 = get()

    try:
        values = expand_single_child_nodes(A1)
        # put(f"前{N}个节点的值为: {values}")  # 输出: [1, 2, 3, 4]
        
    except ValueError as e:
        put(f"错误: {e}")  


start(solve)
