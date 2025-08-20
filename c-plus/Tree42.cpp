#include "pt4.h"
using namespace std;
void deletetree(PNode p){
    if(p->Left!=NULL){
        deletetree(p->Left);
    }
    if(p->Right!=NULL){
        deletetree(p->Right);
    }
    delete p;
}
// 递归删除小于根节点值的子树
void RemoveLessThanRoot(PNode node, int rootValue, PNode parent, bool isLeftChild) {
    if (node == nullptr) {
        return;
    }
  
    // 先处理子节点
    RemoveLessThanRoot(node->Left, rootValue, node, true);
    RemoveLessThanRoot(node->Right, rootValue, node, false);
  
    // 如果当前节点值小于根节点值
    if (node->Data < rootValue) {
        // 从父节点断开连接
        if (parent != nullptr) {
            if (isLeftChild) {
                parent->Left = nullptr;
            } else {
                parent->Right = nullptr;
            }
        }
        
        // 删除节点及其子树
        deletetree(node);
    }
  }
void Solve()
{
    Task("Tree42");
    PNode root;
    GetP(&root); // 获取树的根节点
    
    if (root != nullptr) {
        int rootValue = root->Data;
        // 特殊处理根节点的左右子树
        RemoveLessThanRoot(root->Left, rootValue, root, true);
        RemoveLessThanRoot(root->Right, rootValue, root, false);
    }
    
    //PutP(root); // 输出处理后的根节点
}
