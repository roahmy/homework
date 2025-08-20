#include "pt4.h"
#include <climits>
#include <string>

using namespace std;

int parseExpression(const string& s, size_t& pos) {
    // 处理数字
    if (isdigit(s[pos])) {
        return s[pos++] - '0';
    }

    // 处理M/m函数
    bool isMax = s[pos] == 'M';
    pos += 2; // 跳过'M('或'm('

    int result = isMax ? INT_MIN : INT_MAX;
    while (s[pos] != ')') {
        int arg = parseExpression(s, pos);
        result = isMax ? max(result, arg) : min(result, arg);
        
        // 处理参数分隔符
        if (s[pos] == ',') pos++;
    }

    pos++; // 跳过')'
    return result;
}

void Solve()
{
    Task("Recur22");
    
    string s;
    pt >> s;
    
    size_t pos = 0;
    pt << parseExpression(s, pos);
}