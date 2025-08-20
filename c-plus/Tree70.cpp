#include "pt4.h"
using namespace std;

Node* findRoot(Node* node) {
    while (node->Parent != nullptr)
        node = node->Parent;
    return node;
}

void Solve() {
    Task("Tree70");
    Node* P1;
    pt >> P1;

    Node* root = findRoot(P1);

    if (P1->Left && P1->Right) {
        // 处理两个子节点的情况（Tree68方法）
        Node* P = P1->Left;
        while (P->Right)
            P = P->Right;

        P1->Data = P->Data; // 替换值

        // 删除P节点
        Node* parent_P = P->Parent;
        Node* child_P = P->Left;

        if (parent_P->Left == P)
            parent_P->Left = child_P;
        else
            parent_P->Right = child_P;

        if (child_P)
            child_P->Parent = parent_P;

        delete P;
    } else {
        // 处理0或1个子节点的情况（Tree67逻辑）
        Node* child = P1->Left ? P1->Left : P1->Right;
        Node* parent_P = P1->Parent;

        if (parent_P) {
            if (parent_P->Left == P1)
                parent_P->Left = child;
            else
                parent_P->Right = child;
        } else {
            root = child; // 更新根节点
        }

        if (child)
            child->Parent = parent_P;

        delete P1;
    }

    pt << (root ? root : nullptr);
}