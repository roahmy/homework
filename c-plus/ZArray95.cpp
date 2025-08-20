// This task must be solved with vector<int>
// or vector<double> (not an array!)
#include <vector>
#include "pt4.h"
using namespace std;

void Solve()
{
    Task("ZArray95");
    int n;
    pt >> n;
        
    vector<int> arr;
    for (int i = 0; i < n; ++i) {
        int val;
        pt >> val;
        arr.push_back(val);
    }
        
    vector<int> result;
    if (!arr.empty()) {
        result.push_back(arr[0]);
        for (size_t i = 1; i < arr.size(); ++i) {
            if (arr[i] != arr[i-1]) {
                result.push_back(arr[i]);
            }
        }
    }

    for (int num : result) {
        pt << num;
    }
}
