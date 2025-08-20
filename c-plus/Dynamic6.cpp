#include "pt4.h"
using namespace std;

void Solve() {
    Task("Dynamic6");  // 确保任务名称正确

    PNode P1;
    pt >> P1;  // 读取栈顶指针

    // 弹出并输出前9个节点
    for (int i = 0; i < 9; ++i) {
        if (P1 == nullptr) {
            // 处理栈不足9个节点的情况（题目保证至少有10个，此判断可省略）
            break;
        }
        
        Node* temp = P1;        // 保存当前节点
        pt << temp->Data;       // 输出节点值
        P1 = P1->Next;          // 移动栈顶指针到下一节点
        delete temp;            // 释放当前节点内存
    }

    // 输出新栈顶地址
    pt << P1;  // P1现在指向第10个节点（新栈顶）

    // 注意：题目不要求释放剩余节点内存
}