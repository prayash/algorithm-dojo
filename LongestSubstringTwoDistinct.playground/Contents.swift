/**
 Given a string s, find the length of the longest substring t that contains at most 2 distinct characters.
 https://leetcode.com/problems/longest-substring-with-at-most-two-distinct-characters/discuss/49708/Sliding-Window-algorithm-template-to-solve-all-the-Leetcode-substring-search-problem.

 Input: "eceba"
 Output: 3
 Explanation: t is "ece" which its length is 3.

 Input: "ccaabbb"
 Output: 5
 Explanation: t is "aabbb" which its length is 5.
 */

class Solution {
    // Brute force: O(n ^ 3) 🤮
    func lengthOfLongestSubstringTwoDistinctNaive(_ s: String) -> Int {
        guard s.count > 0 else {
            return s.count
        }

        var maxSubstringLength = 0

        for i in 0..<s.count {
            for j in i + 1...s.count {
                if isUnique(s, start: i, end: j) {
                    maxSubstringLength = max(maxSubstringLength, j - i)
                }
            }
        }

        return maxSubstringLength
    }

    // Check if all characters in a given substring don't exceed the 2 char limit
    private func isUnique(_ s: String, start: Int, end: Int) -> Bool {
        var set = Set<Character>()
        let s = Array(s)

        for i in start..<end {
            let char = s[i]

            set.insert(char)

            if set.count > 2 {
                return false
            }
        }

        return true
    }

    // Sliding window approach: O(n) time and O(1) space
    func lengthOfLongestSubstringTwoDistinct(_ s: String) -> Int {
        let s = Array(s)
        var charMap = [Character: Int]()
        var left = 0
        var maxLength = 0
        var result = ""

        for right in 0..<s.count {
            charMap[s[right], default: 0] += 1

            while charMap.count > 2 {
                charMap[s[left]] = charMap[s[left]]! - 1

                if charMap[s[left]]! == 0 {
                    charMap[s[left]] = nil
                }

                left += 1
            }

            if right - left + 1 > maxLength {
                result = String(s[left...right])
            }

            maxLength = max(maxLength, right - left + 1)
        }

        print(result)

        return maxLength
    }
}

//print(Solution().lengthOfLongestSubstringTwoDistinct("eceba"))
//print(Solution().lengthOfLongestSubstringTwoDistinct("aa"))
//print(Solution().lengthOfLongestSubstringTwoDistinct("ccaabbb"))
//print(Solution().lengthOfLongestSubstringTwoDistinct("abc"))
//print(Solution().lengthOfLongestSubstringTwoDistinct("abaccc"))
//print(Solution().lengthOfLongestSubstringTwoDistinct("ababcbcbaaabbdef"))
print(Solution().lengthOfLongestSubstringTwoDistinct("abcbbbbcccbdddadacb"))
