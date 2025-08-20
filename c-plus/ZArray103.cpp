// This task must be solved with vector<int>
// or vector<double> (not an array!)
#include <vector>
#include "pt4.h"
using namespace std;

void Solve()
{
    Task("ZArray103");
    int N;
    pt >> N;
    vector<double> arr(N);
    for (int i = 0; i < N; ++i)
        pt >> arr[i];
    
    if (N == 0) {
        pt << arr;
        return;
    }
    
    int original_i_max = 0, original_i_min = 0;
    double max_val = arr[0], min_val = arr[0];
    for (int i = 1; i < N; ++i) {
        if (arr[i] > max_val) {
            max_val = arr[i];
            original_i_max = i;
        }
        if (arr[i] < min_val) {
            min_val = arr[i];
            original_i_min = i;
        }
    }
    
    arr.insert(arr.begin() + original_i_max + 1, 0.0);
    
    if (original_i_min > original_i_max) {
        original_i_min += 1;
    }
    
    arr.insert(arr.begin() + original_i_min, 0.0);
    
    for (double num : arr)
        pt << num;
}