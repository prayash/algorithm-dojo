/**
 Given an array of strings, group anagrams together.
 Example:

 Input: ["eat", "tea", "tan", "ate", "nat", "bat"],
 Output:
 [
   ["ate","eat","tea"],
   ["nat","tan"],
   ["bat"]
 ]
 Note:

 All inputs will be in lowercase.
 The order of your output does not matter.
 */

class Solution {
    /// This is an O(n * n log k) solution due to the lexical sorting for hash creation, where
    /// k is the longest string in the input array and n is the size of the input array.
    /// A better approach would be to avoid sorting and build some sort of hashing signature using
    /// character counts for each word.
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var table: [String: [String]] = [:]

        for s in strs {
            let key = String(s.sorted())

            table[key, default: [String]()].append(s)
        }

        return Array(table.values)
    }
}

print(Solution().groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))
