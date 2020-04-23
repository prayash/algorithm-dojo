/**
 Given a string S and a string T, find the minimum window in S which will contain all the
 characters in T in complexity O(n).

 Input: S = "ADOBECODEBANC", T = "ABC"
 Output: "BANC"
 */

class Solution {
    /**
     Sliding window approach: Use two pointers `start` and `end`, and increment `end`
     until we find a valid window. A valid window is when we encounter every character
     in `t`. Once we find a valid window, we'll move the `start` pointer to find a
     smaller window.
     - Complexity: O(n) time and space
     */
    func minWindow(_ s: String, _ t: String) -> String {
        let s = Array(s)
        var start = 0, end = 0
        var counter = t.count
        var minStart = 0
        var minLength = Int.max

        var required = t.reduce(into: [Character: Int]()) { result, char in
            result[char, default: 0] += 1
        }

        while end < s.count {
            // If the char exists in the charMap, decrease the counter
            if let count = required[s[end]] {
                if count > 0 {
                    counter -= 1
                }

                // Decrease the char count in the map
                required[s[end]]? -= 1
                print(required.description)
            }

            // Keep expanding the window towards the right
            end += 1

            // We've found a valid window
            while counter == 0 {
                let length = end - start

                // If the substring we've found is shorter, update!
                if length < minLength {
                    minStart = start
                    minLength = length
                }

                required[s[start]]? += 1
                print(required.description)

                // If the starting char exists in the charMap, increment counter
                if let count = required[s[start]] {
                    if count > 0 {
                        counter += 1
                    }

                }

                // Shrink left edge of the window
                start += 1
            }
        }

        // An updated minLength indicates we have found a solution
        return minLength != Int.max
            ? String(s[minStart..<(minLength + minStart)])
            : ""
    }
}

//print(Solution().minWindow("ADOBECODEBANC", "ABC"))
//print(Solution().minWindow("DADDDBBDCA", "ABC"))
print(Solution().minWindow("ABCZDACB", "ABCD"))
