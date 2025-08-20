#include "pt4.h"
using namespace std;

struct TListB {
    PNode Barrier;   // 屏障节点（标记链表边界）
    PNode Current;    // 当前操作节点
};

// 在Current节点后插入新节点，并更新Current
void LBInsertAfter(TListB &L, int D) {
    // 创建新节点并初始化数据
    PNode newNode = new Node;
    newNode->Data = D;
    
    // 调整指针链接
    newNode->Prev = L.Current;
    newNode->Next = L.Current->Next;
    
    if (L.Current->Next != nullptr)  // 若当前节点不是尾节点
        L.Current->Next->Prev = newNode;
    
    L.Current->Next = newNode;      // 当前节点的Next指向新节点
    L.Current = newNode;            // 更新Current为新节点
}

void Solve() {
    Task("Dynamic77");
    
    TListB L;
    int D;
    
    // 读取屏障指针和当前指针
    pt >> L.Barrier >> L.Current;
    
    // 插入5个整数
    for (int i = 0; i < 5; ++i) {
        pt >> D;               // 读取输入数据
        LBInsertAfter(L, D);   // 执行插入操作
    }
    
    // 输出新的当前节点地址
    pt << L.Current;
}
