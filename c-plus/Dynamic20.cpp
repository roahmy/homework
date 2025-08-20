#include "pt4.h"
using namespace std;

void Solve()
{
    Task("Dynamic20");
    PNode path1,path2,tmp;
    pt >> path1 >> path2;
    while(path1 && (path1->Data & 1)){
        tmp=path1;
        pt << path1->Data;
        path1=path1->Next;
        delete tmp;
    }
    if(!path1){
        path2=nullptr;
    }
    pt<<path1<<path2;
}
