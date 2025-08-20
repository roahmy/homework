#include "pt4.h"
using namespace std;
PNode BuildTree(int* sequence, int& index, int depth, int maxDepth, int N) {
    // 如果达到最大深度或已用完所有数据，停止创建节点
    if (depth > maxDepth || index >= N) {
        return nullptr;
    }
    
    // 创建当前节点
    PNode node = new Node;
    node->Data = sequence[index++];
    node->Left = nullptr;
    node->Right = nullptr;
    
    // 只有当还有数据时才递归创建子树
    if (index < N) {
        node->Left = BuildTree(sequence, index, depth + 1, maxDepth, N);
    }
    if (index < N) {
        node->Right = BuildTree(sequence, index, depth + 1, maxDepth, N);
    }
    
    return node;
}
void Solve()
{
    Task("Tree31");
    int L, N;
    GetN(&L); // 读取树的深度L
    GetN(&N); // 读取序列长度N
    
    // 读取序列
    int* sequence = new int[N];
    for (int i = 0; i < N; ++i) {
        GetN(&sequence[i]);
    }
    
    int index = 0;
    PNode root = BuildTree(sequence, index, 0, L, N);
    
    PutP(root); // 输出根节点地址
    
    delete[] sequence;
}
