from pt4 import *

# 给定一个表示非空树结构的字符串 S，其语法定义如下（不使用空白字符）：
# <树> ::= <空字符串> | <节点>(<左子树>,<右子树>)
# <节点> ::= <数字>
# 需要实现以下操作：
# 1、将字符串 S 解析为树数据结构
# 2、返回树根节点的引用

def parse_tree(s: str) -> Node:
    
    # 将结构化字符串解析为树形数据结构
    # 算法设计：
    #   - 基于递归下降解析法 (Recursive Descent Parsing)
    #   - 时间复杂度：O(n) 线性扫描字符串
    #   - 空间复杂度：O(h) 递归深度(h为树高度)
    
    # 参数:
    #     s: 树结构字符串 (格式如"4(2(,),6(,7(3(,),)))")
    
    # 返回:
    #     树的根节点引用
        
    # 异常:
    #     ValueError: 输入字符串不符合语法规范
    
    index = 0  # 字符串扫描指针
    
    def parse_subtree() -> Node:
        nonlocal index
        if index >= len(s):
            return None
        
        # 情况1: 空子树 (逗号或右括号)
        if s[index] in (',', ')'):
            return None
        
        # 情况2: 解析节点 (必须为单个数字)
        if not s[index].isdigit():
            raise ValueError(f"语法错误(位置{index}): 期望数字, 实际 '{s[index]}'")
        
        # 创建新节点 (使用原节点结构)
        node = Node(data=int(s[index]))
        index += 1
        
        # 情况3: 有子树结构
        if index < len(s) and s[index] == '(':
            index += 1  # 跳过'('
            node.Left = parse_subtree()  # 递归解析左子树
            
            if index < len(s) and s[index] == ',':
                index += 1  # 跳过','
                node.Right = parse_subtree()  # 递归解析右子树
            else:
                raise ValueError(f"语法错误(位置{index}): 期望逗号分隔子树")
            
            if index >= len(s) or s[index] != ')':
                raise ValueError(f"语法错误(位置{index}): 期望右括号结束子树")
            index += 1  # 跳过')'
        
        return node
    
    try:
        root = parse_subtree()
        if index != len(s):
            raise ValueError(f"语法错误: 未解析的尾部字符 '{s[index:]}'")
        return root
    except Exception as e:
        raise ValueError(f"解析失败: {str(e)}")


def solve():
    task("Tree72")

    S = get()

    try:
        root = parse_tree(S)
        put(root)
        
    except ValueError as e:
        put(f"错误: {e}")   

start(solve)
