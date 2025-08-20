from pt4 import *
# from collections.abc import Sequence

# 给定整数 N（满足 N > 0）、包含 N 个整数的序列，以及非递归搜索树的根节点引用 A1（若树为空，则 A1 = None）。需执行以下操作：
# 1、将序列中的 N 个整数作为新节点添加到树中
# 2、保持树仍为非递归搜索树结构
# 3、输出结果树的根节点引用 A2
# 4、请使用以下递归算法实现此功能(此要求是题干给出的按62题的算法)：
# 4.1、对于树根A：若A为None，则创建一个值为K的叶节点并使A指向该节点
# 4.2、若树根存在，则根据K与当前根节点值的比较结果，对左子树（当K小于根节点值时）或右子树（当K大于根节点值时）递归应用上述算

def recursive_insert(root, value):
    
    # 递归插入节点到二叉搜索树
    # 算法遵循：
    # 1. 若树根为None，则创建值为K的叶节点
    # 2. 若树根存在，则根据K与当前节点值的比较递归插入左/右子树
    
    # 情况1：树为空，创建新节点作为根节点[1,2,3](@ref)
    if root is None:
        return Node(value)
    
    # 情况2：递归插入[1,2,3,5](@ref)
    if value < root.Data:
        root.Left = recursive_insert(root.Left, value)
    elif value > root.Data:
        root.Right = recursive_insert(root.Right, value)
    # 值相等时不插入（保持唯一性）
    
    return root

def build_bst_from_sequence(A1, sequence):
    
    # 将整数序列插入二叉搜索树
    # :param A1: 初始树根（可为None）
    # :param sequence: 待插入的整数序列
    # :return: 插入完成后的树根A2
    
    current_root = A1
    for value in sequence:
        current_root = recursive_insert(current_root, value)
    return current_root

# 主处理函数
def process_tree(N, sequence, A1=None):
    
    # 处理函数：构建二叉搜索树并返回根节点
    # :param N: 整数个数（验证使用）
    # :param sequence: 包含N个整数的序列
    # :param A1: 初始树根（可为None）
    # :return: 结果树根A2
    
    # 验证序列长度
    if len(sequence) != N:
        raise ValueError("序列长度与N不匹配")
    
    # 构建二叉搜索树
    A2 = build_bst_from_sequence(A1, sequence)
    return A2

def solve():
    task("Tree64")

    N = get_int()

    # 不能使用get_list()方法获取序列，否则获得的序列个数会少于给定的N,少一个
    # 循环获取序列值，并加入到序列数据中
    sequence: list = []
    i = 1
    while i <= N:
        # print(i)
        val = get()
        sequence.append(val)
        # print(sequence)
        i = i + 1

    # 获取第三个参数Node，有可能获得的Node节点为None    
    A1 = get_Node()
    
    
    # for i in range(len(sequence)-1, -1, -1):
    #     if type(sequence[i]) == Node:
    #         A1 = sequence[i]
    #         del sequence[i]

    # if (type(A1) != Node):
    #     A1 = get()
    # A1 = get()

    try:
        A2 = process_tree(N, sequence, A1)
        # put(f"前{N}个节点的值为: {values}")  # 输出: [1, 2, 3, 4]
        put(A2)

    except ValueError as e:
        put(f"错误: {e}")


start(solve)
