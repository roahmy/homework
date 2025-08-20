#include "pt4.h"
#include <fstream>
using namespace std;

int N;
ofstream fout;

void Generate(string p, int l, int s, char lastChar) 
{
    if (l == N)
    {
        if (s == 0)
            fout << p << '\n';
        return;
    }
    
    if (lastChar != 'A')
        Generate(p + "A", l + 1, s + 1, 'A');
    
    if (lastChar != 'B')
        Generate(p + "B", l + 1, s, 'B');
    
    if (lastChar != 'C')
        Generate(p + "C", l + 1, s - 1, 'C');
}

void Solve()
{
    Task("Recur30");
    string filename;
    pt >> N >> filename;
    fout.open(filename);
    Generate("D", 0, 0, 'D');
    fout.close();
}