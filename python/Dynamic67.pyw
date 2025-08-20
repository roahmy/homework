from pt4 import *

class IntList:
    def __init__(self, head, tail, current):
        self.head = head
        self.tail = tail
        self.current = current
    
    def Add(self, other):
        if not other.head:  # 若L1为空，直接返回
            return
        
        # 将L1连接到L2尾部
        if self.tail:
            self.tail.Next = other.head
            other.head.Prev = self.tail
            self.tail = other.tail
        else:  # L2为空的情况（题目保证非空）
            self.head = other.head
            self.tail = other.tail
        
        # 更新L2的当前节点为L1的第一个节点
        self.current = other.head
        
        # 清空L1
        other.head = None
        other.tail = None
        other.current = None

def solve():
    task("Dynamic67")
    
    # 读取输入：L1的头、尾、当前节点，L2的头、尾、当前节点
    L1_head = get()
    L1_tail = get()
    L1_current = get()
    L2_head = get()
    L2_tail = get()
    L2_current = get()
    
    # 创建IntList对象
    L1 = IntList(L1_head, L1_tail, L1_current)
    L2 = IntList(L2_head, L2_tail, L2_current)
    
    # 执行合并操作
    L2.Add(L1)
    
    # 输出合并后L2的头、尾、当前节点
    put(L2.head)
    put(L2.tail)
    put(L2.current)

start(solve)
