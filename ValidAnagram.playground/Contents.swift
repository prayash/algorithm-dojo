/**
 Given two strings s and t , write a function to determine if t is an anagram of s.

 Example 1:

 Input: s = "anagram", t = "nagaram"
 Output: true
 Example 2:

 Input: s = "rat", t = "car"
 Output: false
 Note:
 You may assume the string contains only lowercase alphabets.

 Follow up:
 What if the inputs contain unicode characters? How would you adapt your solution to such case?
 */

class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }

        var map: [Character: Int] = [:]

        s.forEach { map[$0, default: 0] += 1 }

        for c in t {
            map[c, default: 0] -= 1

            if map[c]! < 0 {
                return false
            }
        }

        return true
    }
}

print(Solution().isAnagram("anagram", "nagaram"))
print(Solution().isAnagram("rat", "car"))
