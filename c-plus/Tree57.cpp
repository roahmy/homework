#include "pt4.h"
#include <vector>
using namespace std;
vector<int> v1;

PNode fun(PNode p1)
{
	PNode p2 = nullptr;
	if(p1->Left){
		p2 = fun(p1->Left);
	}
	if(p2){
		return p2;
	}
	for(int m=0;m<v1.size();m++){
		if(p1->Data <v1[m]){
			return p1;
		}
	}
	v1.push_back(p1->Data);
	if(p1->Right){
		p2 = fun(p1->Right);
	}
	return p2;
}

void Solve()
{
    Task("Tree57");
    PNode p1;
	pt >> p1;
	pt << fun(p1);

}