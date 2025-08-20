#include "pt4.h"
using namespace std;

void Solve()
{
    Task("String34");
    string S, Sg;
    pt >> S >> Sg;
    
    size_t lastPos = S.rfind(Sg);
    
    if (lastPos != string::npos) {
        S.erase(lastPos, Sg.length());
    }
    
    pt << S;
}