#include "pt4.h"
#include <vector>
#include <algorithm> 
using namespace std;

void Solve()
{
    Task("String50");
    string str;
    pt >> str;
    
    vector<string> words;
    string word;
    
    for (char c : str) {
        if (c == ' ') {
            if (!word.empty()) {
                words.push_back(word);
                word.clear();
            }
        } else {
            word += c;
        }
    }
    if (!word.empty()) {
        words.push_back(word);
    }
    
    reverse(words.begin(), words.end());
    
    string result;
    for (size_t i = 0; i < words.size(); ++i) {
        if (i > 0) {
            result += " ";
        }
        result += words[i];
    }
    
    pt << result;
}