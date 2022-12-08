#include <string> 
#include <iostream> 
#include <fstream>
#include <sstream>
#include <set>
#include <vector>
#include <algorithm>
#include <iterator>
#include <map>
#include <string_view>
#include <numeric>

using namespace std;

vector<string> split(string str, char delimiter) {
    vector<string> tokens;
    string token;
    stringstream ss(str);

    while (getline(ss, token, delimiter)){
        tokens.push_back(token);
    }

    return tokens;
}

int getSizes(vector<string>& lines, size_t* idx, vector<long>& sizes, long* solution1) {
    long size = 0;

    while (*idx < lines.size()) {
        string line = lines[*idx];
        *idx += 1;

        if (line == "$ cd ..") {
            break;
        }

        if (isdigit(line[0])) {
            int space = line.find(' ');
            size += stoi(line.substr(0, space));
        } else if (line.substr(0, 4) == "$ cd") {
            size += getSizes(lines, idx, sizes, solution1);
        }
    }

    if (size < 100000) {
        *solution1 += size;
    }
    sizes.push_back(size);
    return size;
}

long solution2(vector<long> sizes) {
    long total = 70000000;
    long needed = 30000000;
    sort(sizes.begin(), sizes.end());

    long used = sizes[sizes.size() - 1];

    for (auto size : sizes) {
        if (total - used + size >= needed) {
            return size;
        }
    }

    return 0;
}

int main() {
    ifstream f("sample.txt");
    string str;
    if(f) {
        ostringstream ss;
        ss << f.rdbuf();
        str = ss.str();
    }
    vector<string> lines = split(str, '\n');
    size_t idx = 0;

    vector<long> sizes;

    long solution1 = 0;

    getSizes(lines, &idx, sizes, &solution1);

    cout << "Answer 1: " << solution1 << endl;
    cout << "Answer 2: " << solution2(sizes) << endl;
    
    return 0;
}