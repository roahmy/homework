#include "pt4.h"
using namespace std;
int MAXPV=999999999;
int v=0;
void NodeMax(PNode p)
{
    if(p->Data<MAXPV){
        MAXPV=p->Data;
    }
    if(p->Left!=NULL)
        NodeMax(p->Left);
    if(p->Right!=NULL)
        NodeMax(p->Right);
}
void CountLeaf(PNode p){
    if(p->Left!=NULL)
       CountLeaf(p->Left);
    if(p->Right!=NULL)
        CountLeaf(p->Right);
    if(p->Left==NULL&&p->Right==NULL&&p->Data==MAXPV){
        v++;
    }
}
void Solve()
{
    Task("Tree20");
    MAXPV=999999999;
    v=0;
    PNode p1;
    GetP(&p1);
    NodeMax(p1);
    CountLeaf(p1);
    PutN(MAXPV);
    PutN(v);
}
