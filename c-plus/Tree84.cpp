#include "pt4.h"

// 解析树节点类型定义
// 假设已经包含在pt4.h中
// 内部节点：-1表示M函数，-2表示m函数
// 叶子节点：数字值(0-9)

// 递归计算解析树表达式的值
int EvaluateParseTree(PNode root) {
    if (root == nullptr) {
        return 0; // 不应该发生，题目保证树非空
    }
    
    // 如果是叶子节点（数字）
    if (root->Data >= 0) {
        return root->Data;
    }
    
    // 计算左右子树的值
    int leftVal = EvaluateParseTree(root->Left);
    int rightVal = EvaluateParseTree(root->Right);
    
    // 根据节点类型应用相应函数
    switch (root->Data) {
        case -1: // M函数，取最大值
            return (leftVal > rightVal) ? leftVal : rightVal;
        case -2: // m函数，取最小值
            return (leftVal < rightVal) ? leftVal : rightVal;
        default: // 不应该发生
            return 0;
    }
}

void Solve() {
    Task("Tree84"); // 题目编号已去除特殊符号
    
    PNode root;
    GetP(&root); // 获取解析树的根节点
    
    int result = EvaluateParseTree(root);
    
    PutN(result); // 输出表达式计算结果
}