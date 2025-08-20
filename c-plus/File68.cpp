#include "pt4.h"
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

void Solve()
{

    Task("File68");
    string inputFile, monthFile, yearFile;
    pt >> inputFile >> monthFile >> yearFile;
    ifstream inFile(inputFile, ios::binary);
    
    vector<int> months, years;
    char date[80];
    
    while (inFile.read(date, sizeof(date))) {
        string dateStr(date);
        size_t slash1 = dateStr.find('/');
        size_t slash2 = dateStr.find('/', slash1 + 1);
        int month = stoi(dateStr.substr(slash1 + 1, slash2 - slash1 - 1));
        int year = stoi(dateStr.substr(slash2 + 1));
        
        months.push_back(month);
        years.push_back(year);
    }
    
    inFile.close();
    reverse(months.begin(), months.end());
    reverse(years.begin(), years.end());
    ofstream outMonth(monthFile, ios::binary);
    
    for (int m : months) {
        outMonth.write(reinterpret_cast<const char*>(&m), sizeof(m));
    }
    outMonth.close();
    ofstream outYear(yearFile, ios::binary);
    
    for (int y : years) {
        outYear.write(reinterpret_cast<const char*>(&y), sizeof(y));
    }
    outYear.close();
}
