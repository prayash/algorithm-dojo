/**
 Given a string, find the length of the longest substring without repeating characters.

 Examples:
 Input: "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.

 Input: "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.

 Input: "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
      Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */

class Solution {
    // Brute force: O(n ^ 3) 🤮
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let length: Int = s.count
        var answer: Int = 0

        // Enumerate all substrings of s, checking if it has any duplicates each iteration
        for i in 0..<length {
            for j in i + 1...length {
                if allUnique(s, start: i, end: j) {
                    // Update the final count with the max of what we've found
                    answer = max(answer, j - i)
                }
            }
        }

        return answer
    }

    // Check if all characters in a given substring are unique
    func allUnique(_ s: String, start: Int, end: Int) -> Bool {
        var set = Set<Character>()
        let letters = Array(s)

        for i in start..<end {
            let char = letters[i]

            if set.contains(char) {
                return false
            }

            set.insert(char)
        }

        return true
    }

    // Sliding window: O(2n) = O(n) 🤗
    // Repeatedly checking a substring to see if it has duplicates is unnecessary.
    // If while enumerating, a substring s[i..<j] is already checked to have duplicates,
    // we only need to check if s[j] is already in the substring.
    // Using a Set as a sliding window, lookup can be done in O(1)
    func lengthOfLongestSubstringWindowed(_ s: String) -> Int {
        guard s.count > 0, s.count > 1 else { return s.count }

        let length: Int = s.count
        let letters = Array(s)

        var set = Set<Character>()
        var answer: Int = 0
        var i = 0, j = 0

        // Slide index j to the right, expanding the window and checking against the Set
        // If it's not, we expand further until s[j] is already in the Set, meaning
        // we found the max sized substring without duplicates. Repeat for all i!
        while i < length && j < length {
            // No dups found, insert into Set and keep expanding window
            if !set.contains(letters[j]) {
                set.insert(letters[j])
                j += 1
                answer = max(answer, j - i)
            } else {
                // Dupe found, advance the left bound of the window
                set.remove(letters[i])
                i += 1
            }
        }

        return answer
    }
}

var inputString = "abcabcbb"
print("\(inputString) \(Solution().lengthOfLongestSubstringWindowed(inputString))")

inputString = "bbbbb"
print("\(inputString) \(Solution().lengthOfLongestSubstringWindowed(inputString))")

inputString = "pwwkew"
print("\(inputString) \(Solution().lengthOfLongestSubstringWindowed(inputString))")

inputString = "au"
print("\(inputString) \(Solution().lengthOfLongestSubstringWindowed(inputString))")
