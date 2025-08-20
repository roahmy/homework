#include <queue>
#include <vector>

#include "pt4.h"

using namespace std;

// 计算并输出每层节点值之和
std::vector<int> levelSum(Node* root) {
    std::vector<int> sums;
    if (!root) return sums;
    
    // 把节点加入队列
    std::queue<Node*> q;
    q.push(root);
    
    while (!q.empty()) {
        int levelSize = q.size();
        int currentSum = 0;

        for (int i = 0; i < levelSize; ++i) {
            Node* node = q.front();
            q.pop();
            currentSum += node->Data;

            // 处理子节点：假设子节点通过 Left 和 Right 指针组织成链表
            Node* child = node->Left;
            while (child) {
                q.push(child);
                child = child->Right; // 移动到下一个兄弟节点
            }
        }

        sums.push_back(currentSum);
    }

    return sums;
}

void Solve() {
    Task("Tree90");
    Node* P1;

    // 获取tree根节点P1
    pt >> P1;

   // 计算各层节点值之和
    std::vector<int> sums = levelSum(P1);

    // 输出结果
    //std::cout << "各层节点值之和：" << std::endl;
    for (int sum : sums) {
        //std::cout << sum << std::endl;
        PutN(sum); // 输出每一层结果
    }

    return;
}