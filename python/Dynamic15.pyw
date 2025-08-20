from pt4 import *

class Queue:
    def __init__(self):
        self.head = None
        self.tail = None
    
    def enqueue(self, data):
        new_node = Node(data)
        if self.head is None:
            self.head = new_node
            self.tail = new_node
        else:
            self.tail.Next = new_node
            self.tail = new_node

def solve():
    task("Dynamic15")
    
    # 读取10个整数
    nums = [get() for _ in range(10)]
    
    # 初始化两个队列
    q1 = Queue()  # 奇数序号队列
    q2 = Queue()  # 偶数序号队列
    
    # 分配元素到队列
    for idx, num in enumerate(nums, 1):
        if idx % 2 == 1:
            q1.enqueue(num)
        else:
            q2.enqueue(num)
    
    # 输出结果
    put(q1.head)
    put(q1.tail)
    put(q2.head)
    put(q2.tail)

start(solve)
