#include "pt4.h"
using namespace std;

void SortInc3(double &A, double &B, double &C)
{
    if (A > B) swap(A, B);
    if (A > C) swap(A, C);
    if (B > C) swap(B, C);
}
void Solve()
{
    Task("ZFunc33");
    int T = 2;
    double A, B, C;
    
    while (T--)
    {
        pt >> A >> B >> C;
        
        SortInc3(A, B, C);
        
        pt << A << B << C;
    }
}
