from pt4 import *

def solve():
    task("Dynamic23")
    
    # 读取输入：队列1的头A1、尾A2，队列2的头A3、尾A4
    A1, A2 = get(), get()  # 队列1的头尾
    A3, A4 = get(), get()  # 队列2的头尾
    
    # 移动节点直到队列1的头为偶数或队列1为空
    current = A1
    while current and current.Data % 2 != 0:
        # 从队列1移除头节点
        moved_node = current
        next_node = current.Next
        
        # 更新队列1的头
        if next_node:
            A1 = next_node
        else:
            A1 = None
            A2 = None  # 队列1已空
        
        # 将节点加入队列2尾部
        if A4 is None:  # 队列2为空（但题目保证非空）
            A3 = A4 = moved_node
        else:
            A4.Next = moved_node
            A4 = moved_node
        A4.Next = None  # 新尾节点Next置空
        
        current = A1  # 更新当前头检查
    
    # 输出结果
    put(A1 if A1 else None)
    put(A2 if A1 else None)  # 队列1非空时A2有效，否则为None
    put(A3)
    put(A4)

start(solve)
