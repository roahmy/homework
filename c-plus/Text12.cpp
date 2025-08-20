#include "pt4.h"
#include <fstream>
#include <string>
using namespace std;

void Solve()
{
    Task("Text12");

    string S, filename;
    pt >> S >> filename;

    ifstream fin(filename);
    string content;
    string line;
    bool firstLine = true;

    while (getline(fin, line)) {
        if (!firstLine) {
            content += "\n";
        }
        
        if (line.empty()) {
            content += S;
        } else {
            content += line;
        }
        
        firstLine = false;
    }
    fin.close();

    ofstream fout(filename);
    fout << content;
    fout.close();
}