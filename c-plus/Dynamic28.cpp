#include "pt4.h"
using namespace std;

// 定义队列结构：用带头节点的链表实现
// Head指向队首节点，Tail指向队尾节点
struct TQueue 
{
    PNode Head;  // 队头指针（指向第一个有效节点）
    PNode Tail;  // 队尾指针（指向最后一个节点）
};

// 出队函数：移除队首节点并返回其数据
int Dequeue(TQueue &Q)
{
    PNode oldHead = Q.Head;      // 保存当前队头指针
    int value = oldHead->Data;  // 获取队头数据
    
    Q.Head = Q.Head->Next;       // 队头指针后移
    if (Q.Head == nullptr)       // 如果队列已空
        Q.Tail = nullptr;        // 同时清空队尾指针
    
    DeleteNode(oldHead);         // 调用PT4平台提供的节点释放函数
    return value;                // 返回出队的数据
}

// 判断队列是否为空
bool QueueIsEmpty(TQueue Q)
{
    return Q.Head == nullptr;  // 队头为空即队列为空
}

void Solve()
{
    Task("Dynamic28");  // 声明当前处理的题目编号
    
    // 从PT4平台获取两个节点（可能是预先构建好的链表头节点）
    PNode Path1 = GetNode();  // 假设Path1是队列的起始节点
    PNode Path2 = GetNode();  // 假设Path2是队列的结束节点
    
    // 初始化队列结构（注意此处可能存在问题）
    TQueue Q = {Path1, Path2};  // Head=Path1, Tail=Path2
    
    int count = 0;
    // 循环出队最多5个元素（题目可能要求处理前5个元素）
    while (count < 5 && !QueueIsEmpty(Q))
    {
        pt << Dequeue(Q);  // 输出出队元素
        count++;
    }
    
    // 输出队列状态信息（题目要求的后续操作）
    pt << QueueIsEmpty(Q);  // 输出队列是否为空（0/1）
    pt << Q.Head << Q.Tail;  // 输出当前队头、队尾地址
}