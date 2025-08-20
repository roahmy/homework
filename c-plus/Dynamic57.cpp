#include "pt4.h"
using namespace std;

void Solve()
{
    Task("Dynamic57");
    
    int K;
    PNode P1, P2;
    pt >> K >> P1 >> P2; // 输入K和头尾指针
    
    // 计算链表长度L（通过遍历头到尾）
    int L = 1;
    PNode current = P1;
    while (current != P2) {
        L++;
        current = current->Next;
    }
    
    int shift = K % L;
    if (shift == 0) { // 若无需移动，直接输出原头尾
        pt << P1 << P2;
        return;
    }
    
    // 将链表转换为循环链表
    P2->Next = P1;
    P1->Prev = P2;
    
    // 找到新头节点：从原头移动 (L - shift) 次
    current = P1;
    for (int i = 0; i < (L - shift); ++i)
        current = current->Next;
    
    PNode new_head = current;
    PNode new_tail = current->Prev; // 新尾是新头的前驱
    
    // 断开循环链表
    new_head->Prev = nullptr;
    new_tail->Next = nullptr;
    
    pt << new_head << new_tail; // 输出新头尾地址
}
