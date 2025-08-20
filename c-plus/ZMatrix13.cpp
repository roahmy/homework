// This task must be solved with vector<vector<int>>
// or vector<vector<double>> (not an array!)
#include <vector>
#include "pt4.h"
using namespace std;

void Solve()
{
    Task("ZMatrix13");
    int M;
    pt >> M;
    vector<vector<double>> matrix(M, vector<double>(M));
    
    for (int i = 0; i < M; ++i)
        for (int j = 0; j < M; ++j)
            pt >> matrix[i][j];
    
    vector<double> result;
    int top = 0, bottom = M - 1, left = 0, right = M - 1;
    bool rowTurn = true;
    
    while (top <= bottom && left <= right) {
        if (rowTurn) {
            for (int j = left; j <= right; ++j)
                result.push_back(matrix[top][j]);
            top++;
        } else {
            for (int i = top; i <= bottom; ++i)
                result.push_back(matrix[i][right]);
            right--;
        }
        rowTurn = !rowTurn;
    }
    
    if (M > 0 && result.back() != matrix[M-1][0])
        result.push_back(matrix[M-1][0]);
    
    for (double num : result)
        pt << num;
}