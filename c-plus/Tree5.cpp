#include "pt4.h"
using namespace std;
int NodeCount(PNode p)
{
    int tot=0;
    if(p->Left!=NULL)
        tot++;
    if(p->Left!=NULL)
        tot+=NodeCount(p->Left);
    if(p->Right!=NULL)
        tot+=NodeCount(p->Right);
    return tot;
}

void Solve()
{
    Task("Tree5");
    PNode p1;
    GetP(&p1);
    PutN(NodeCount(p1));
}
