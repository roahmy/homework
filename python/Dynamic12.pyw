from pt4 import *

class IntStack:
    def __init__(self, top):
        self.__top = top
    
    def push(self, d):
        self.__top = Node(d, self.__top)
    
    def pop(self):
        if self.__top is None:
            return None  # 理论上题目保证栈至少有5个节点，此处可省略
        old_top = self.__top
        self.__top = old_top.Next
        value = old_top.Data
        old_top.dispose()  # 必须调用dispose释放资源
        return value
    
    def get_top(self):
        return self.__top

def solve():
    task("Dynamic12")
    
    # 读取输入：栈顶节点A1
    A1 = get()
    
    # 初始化栈
    stack = IntStack(A1)
    
    # 弹出5个元素并输出
    popped_values = []
    for _ in range(5):
        value = stack.pop()
        popped_values.append(value)
    
    # 输出结果
    for v in popped_values:
        put(v)
    put(stack.get_top())  # 输出新栈顶（可能为None）

start(solve)