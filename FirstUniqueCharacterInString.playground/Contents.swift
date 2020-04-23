/**
 Given a string, find the first non-repeating character in it and return it's index.
 If it doesn't exist, return -1.

 s = "leetcode"
 return 0.

 s = "loveleetcode",
 return 2.
 */

class Solution {
    /**
     Scan through the string, store an occurence count in a dictionary.
     Take another pass through the array and the first character in the hash map
     with an occurence count of 1 is the answer.
     O(n) runtime because we have to scan through the string of length n twice.
     O(26), or O(1) space because at most it'll take 26 slots in the hash map, ever.
     */
    func firstUniqChar(_ s: String) -> Int {
        let string = Array(s)
        var occurences: [Character : Int] = [:]

        // First pass: Store all occurences of the characters
        for i in 0..<string.count {
            let char = string[i]

            if occurences[char] != nil {
                occurences[char]! += 1
            } else {
                occurences[char] = 1
            }
        }

        // Second pass: The 1st character to have a occurence of 1 is the answer
        for i in 0..<string.count {
            let char = string[i]

            if let count = occurences[char], count == 1 {
                return i
            }
        }

        return -1
    }
}

var s = "loveleetcode"
print(Solution().firstUniqChar(s))
