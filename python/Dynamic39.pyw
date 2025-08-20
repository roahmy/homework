from pt4 import *

def solve():
    task("Dynamic39")
    
    current = get()  # 获取原链表头节点A1
    head = current   # 初始化新链表头
    
    while current:
        if current.Data % 2 != 0:  # 当前节点为奇数
            new_node = Node(current.Data)  # 创建重复节点
            
            # 连接新节点到原节点的前驱
            new_node.Prev = current.Prev
            new_node.Next = current
            
            # 处理前驱节点或更新头节点
            if current.Prev:
                current.Prev.Next = new_node
            else:
                head = new_node  # 原节点是头节点时更新头
            
            current.Prev = new_node  # 原节点前驱指向新节点
        
        current = current.Next  # 移动到原节点的下一个节点（跳过新节点）
    
    put(head)  # 输出新链表头

start(solve)
