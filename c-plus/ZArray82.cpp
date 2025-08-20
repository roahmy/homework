// This task must be solved with vector<int>
// or vector<double> (not an array!)
#include <vector>
#include "pt4.h"
#include <algorithm>
using namespace std;

void Solve()
{
    Task("ZArray82");
    int N, K;
    pt >> N;
    vector<double> arr(N);
    for (int i = 0; i < N; ++i)
        pt >> arr[i];
    pt >> K;
    rotate(arr.begin(), arr.begin() + K, arr.end());
    
    for (int i = N - K; i < N; ++i)
        arr[i] = 0;
    
    for (auto num : arr)
        pt << num;
}