#include "pt4.h"
#include <fstream>
#include <string>
using namespace std;

void Solve()
{
    Task("Text18");

    int K;
    string filename;
    pt >> K >> filename;

    ifstream fin(filename);
    string line;
    string result;

    while (getline(fin, line)) {
        if (line.length() > K) {
            result += line.substr(K) + "\n";
        } else {
            result += "\n";
        }
    }
    fin.close();

    ofstream fout(filename);
    fout << result;
    fout.close();
}