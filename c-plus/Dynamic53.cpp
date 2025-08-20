#include "pt4.h"
using namespace std;

void Solve()
{
    Task("Dynamic53");
    PNode PX,PY;
    pt >> PX >> PY;
    PNode beforeX = PX->Prev;
    PNode afterY = PY->Next;
    PNode firstNew = PX;

    if (beforeX) beforeX->Next = afterY;
    if (afterY) afterY->Prev = beforeX;
    PX->Prev = nullptr;
    PY->Next = nullptr;    
    PNode firstOriginal = nullptr;
    
    if (beforeX != nullptr || afterY != nullptr) {
        if (beforeX) firstOriginal = beforeX;
        else firstOriginal = afterY;
        while (firstOriginal->Prev) firstOriginal = firstOriginal->Prev;
    }
    pt << firstOriginal << firstNew;
}
