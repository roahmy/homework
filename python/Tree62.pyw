from pt4 import *

# 给定一个非递归搜索树的根节点A₁和一个整数值K（若树为空，则A₁ = None）。要求向树中添加一个值为K的新节点，并确保结果树仍然是一个有效的非递归搜索树。如果树中已存在值为K的节点，则无需进行任何修改。输出结果树的根节点引用A₂。
# 请使用以下递归算法实现此功能：
# 1、对于树根A：若A为None，则创建一个值为K的叶节点并使A指向该节点
# 2、若树根存在，则根据K与当前根节点值的比较结果，对左子树（当K小于根节点值时）或右子树（当K大于根节点值时）递归应用上述算法

def insert_into_bst(A1, K):
    
    # 递归实现在二叉搜索树中插入新节点
    
    # 参数:
    # A1 -- 二叉搜索树的根节点（如果树为空则为None）
    # K -- 要插入的整数值
    
    # 返回:
    # 插入后的二叉搜索树的根节点
    
    # 1. 如果树为空，创建新节点作为根节点
    if A1 is None:
        return Node(K)
    
    # 2. 递归插入算法
    # 当K小于当前节点值时，向左子树递归插入
    if K < A1.Data:
        A1.Left = insert_into_bst(A1.Left, K)
    # 当K大于当前节点值时，向右子树递归插入
    elif K > A1.Data:
        A1.Right = insert_into_bst(A1.Right, K)
    # 当K等于当前节点值时，不做任何操作（节点已存在）
    
    # 返回当前节点（可能是更新后的子树根节点）
    return A1

def solve():
    task("Tree62")

    A1 = get_Node()
    K = get()
    
    try:
        A2 = insert_into_bst(A1, K)
        put(A2)
        
    except ValueError as e:
        put(f"错误: {e}")  

start(solve)
