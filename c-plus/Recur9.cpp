#include "pt4.h"
using namespace std;

int GCD(int A, int B) {
    if (B == 0)
        return A;
    else
        return GCD(B, A % B);
}

void Solve()
{
    Task("Recur9");
    
    int A, B, C, D;
    pt >> A >> B >> C >> D;
    
    pt << GCD(A, B) << GCD(A, C) << GCD(A, D);
}