#include "pt4.h"
using namespace std;

void Solve()
{
    Task("String30");
    char C;
    string S, S0;
    pt >> C >> S >> S0;
    
    string result;
    for (char ch : S) {
        result += ch;
        if (ch == C) {
            result += S0;
        }
    }
    
    pt << result;
}