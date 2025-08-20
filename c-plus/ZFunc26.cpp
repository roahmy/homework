#include "pt4.h"
#include <cmath>

using namespace std;

void RectPS(double x1, double y1, double x2, double y2, double &P, double &S)
{
    double length = fabs(x2 - x1);
    double width = fabs(y2 - y1);
    P = 2 * (length + width);
    S = length * width;
}

void Solve()
{
    Task("ZFunc26");
    double X1, Y1, X2, Y2, P, S;
    for (int i = 1; i <= 3; i++)
    {
        pt >> X1 >> Y1 >> X2 >> Y2;
        RectPS(X1, Y1, X2, Y2, P, S);
        pt << P << S;
    }
}