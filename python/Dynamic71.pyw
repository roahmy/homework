from pt4 import *

def solve():
    task("Dynamic71")
    
    # 读取输入：原链表的屏障A1和当前节点A2
    A1 = get()  # 屏障节点
    A2 = get()  # 当前节点
    
    # 创建新链表的屏障节点（题目允许）
    new_barrier = Node()
    
    # 情况1：当前节点是屏障（新链表只有屏障）
    if A2 == A1:
        new_barrier.Next = new_barrier
        new_barrier.Prev = new_barrier
    else:
        # 找到原链表的最后一个节点（原链表尾是屏障的Prev）
        last_node = A1.Prev
        
        # 找到当前节点的前一个节点（需要断开）
        prev_node = A2.Prev
        
        # 将原链表的prev_node.Next指向屏障，断开后续节点
        prev_node.Next = A1
        A1.Prev = prev_node
        
        # 将A2到last_node的节点连接到新屏障
        new_barrier.Next = A2
        A2.Prev = new_barrier
        new_barrier.Prev = last_node
        last_node.Next = new_barrier
    
    # 输出新链表的屏障节点
    put(new_barrier)

start(solve)
