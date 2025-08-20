// This task must be solved with vector<vector<int>>
// or vector<vector<double>> (not an array!)
#include <vector>
#include "pt4.h"
using namespace std;

void Solve()
{
    Task("ZMatrix64");
    int M, N;
    pt >> M >> N;
    vector<vector<double>> matrix(M, vector<double>(N));
    
    for (int i = 0; i < M; ++i)
        for (int j = 0; j < N; ++j)
            pt >> matrix[i][j];
    
    double max_val = matrix[0][0];
    int max_col = 0;
    for (int i = 0; i < M; ++i) {
        for (int j = 0; j < N; ++j) {
            if (matrix[i][j] > max_val) {
                max_val = matrix[i][j];
                max_col = j;
            }
        }
    }
    
    vector<vector<double>> new_matrix;
    for (int i = 0; i < M; ++i) {
        vector<double> new_row;
        for (int j = 0; j < N; ++j) {
            if (j != max_col) {
                new_row.push_back(matrix[i][j]);
            }
        }
        new_matrix.push_back(new_row);
    }
    
    for (auto &row : new_matrix) {
        for (double num : row) {
            pt << num;
        }
    }
}