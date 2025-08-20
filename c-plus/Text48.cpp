#include "pt4.h"
#include <fstream>
#include <string>
#include <sstream>
#include <vector>
using namespace std;

void Solve()
{
    Task("Text48");

    string inputFile, outputFile;
    pt >> inputFile >> outputFile;

    ifstream fin(inputFile);
    vector<int> integers;

    string line;
    while (getline(fin, line)) {
        istringstream iss(line);
        string numStr;
        while (iss >> numStr) {
            if (numStr.find('.') == string::npos) {
                try {
                    int num = stoi(numStr);
                    integers.push_back(num);
                } catch (...) {
                }
            }
        }
    }
    fin.close();

    ofstream fout(outputFile, ios::binary);
    for (int num : integers) {
        fout.write(reinterpret_cast<const char*>(&num), sizeof(int));
    }
    fout.close();
}