#include <iostream> 
#include <string.h> 
#include <fstream>
#include <sstream>
#include <set>

using namespace std;

int findMarker(string str, int n) {
    for (int i = 0; i < str.length() - n; i++) {
        set<char> chars;
        for (int j = 0; j < n; j++) {
            chars.insert(str.at(i+j));
        }

        if (chars.size() == n) {
            return i + n;
        }
    }

    return 1;
}

int main() {
    ifstream f("input.txt");
    string str;
    if(f) {
        ostringstream ss;
        ss << f.rdbuf();
        str = ss.str();
    }

    cout << "Answer 1: " << findMarker(str, 4) << "\n";
    cout << "Answer 2: " << findMarker(str, 14);
    return 0;
}
