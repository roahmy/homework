#include "pt4.h"
#include <fstream>
#include <iomanip>
#include <vector>
using namespace std;

void Solve()
{
    Task("Text41");

    string file1, file2, file3, outputFile;
    pt >> file1 >> file2 >> file3 >> outputFile;

    ifstream fin1(file1, ios::binary);
    ifstream fin2(file2, ios::binary);
    ifstream fin3(file3, ios::binary);
    ofstream fout(outputFile);

    int num1, num2, num3;

    while (fin1.read(reinterpret_cast<char*>(&num1), sizeof(int)) &&
           fin2.read(reinterpret_cast<char*>(&num2), sizeof(int)) &&
           fin3.read(reinterpret_cast<char*>(&num3), sizeof(int))) {
        
        fout << "|" 
             << left << setw(20) << num1
             << left << setw(20) << num2
             << left << setw(20) << num3
             << "|\n";
    }

    fin1.close();
    fin2.close();
    fin3.close();
    fout.close();
}