#include "pt4.h"
using namespace std;
PNode FindRoot(PNode node) {
    if (node == nullptr) {
        return nullptr;
    }
    
    // 沿着Parent指针一直向上查找
    while (node->Parent != nullptr) {
        node = node->Parent;
    }
    
    return node;
}

void Solve()
{
    Task("Tree50");
    
    PNode p1;
    GetP(&p1); // 获取输入的节点指针
    
    PNode root = FindRoot(p1); // 查找根节点
    
    PutP(root); // 输出根节点指针
}
