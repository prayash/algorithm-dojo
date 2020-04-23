#include <iostream>
#include <vector>
#include<unordered_map>

using namespace std;
 
 vector<vector<string>> find_anagrams(const vector<string> &dictionary) {
    unordered_map<string, vector<string>> sorted_string_to_anagrams;
    for (const string &s : dictionary) {
        string sorted_str(s);
        sort(sorted_str.begin(), sorted_str.end());
        sorted_string_to_anagrams[sorted_str].emplace_back(s);
    }

    vector<vector<string>> anagram_groups;
    for (const auto &p : sorted_string_to_anagrams) {
        if (p.second.size() >= 2) {
            anagram_groups.emplace_back(p.second);
        }
    }

    return anagram_groups;
}

int main() {
    // Create a vector containing integers
    std::vector<int> v = {7, 5, 16, 8};
    std::vector<string> d = {"debitcard", "badcredit", "levis", "lives", "elvis"};
    std::vector<vector<string>> result = find_anagrams(d);

    // Add two more integers to vector
    v.push_back(25);
    v.push_back(13);

    // Iterate and print values of vector
    for (int n : v) {
        std::cout << n;
    }


    for (int i = 0; i < result.size(); i++) {
        for (int j = 0; j < result[i].size(); j++) {
            cout << result[i][j] << '\n';
        }
    }
}