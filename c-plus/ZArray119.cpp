// This task must be solved with vector<int>
// or vector<double> (not an array!)
#include <vector>
#include "pt4.h"
using namespace std;

void Solve()
{
    Task("ZArray119");
    int n;
    pt >> n;
    vector<int> arr(n);
    for (int i = 0; i < n; ++i)
        pt >> arr[i];
    
    if (n == 0) {
        pt << arr;
        return;
    }
    
    vector<pair<int, int>> series;
    int current = arr[0];
    int count = 1;
    
    for (int i = 1; i < n; ++i) {
        if (arr[i] == current) {
            count++;
        } else {
            series.push_back({current, count});
            current = arr[i];
            count = 1;
        }
    }
    series.push_back({current, count});
    
    vector<int> result;
    for (auto &s : series) {
        for (int j = 0; j < s.second + 1; ++j) {
            result.push_back(s.first);
        }
    }
    
    for (int num : result)
        pt << num;
}
