/**
 Given a string s, find the longest palindromic substring in s. You may assume that the
 maximum length of s is 1000.

 Input: "babad"
 Output: "bab"
 Note: "aba" is also a valid answer.
 */

import Foundation

class Solution {
    /**
     DP: Use a dp table to record whether substring s[i...j] is a palindrome. Keep track
     of the maximum palindromic substring's indices we've seen so far, and return a substring using
     said indices.
     - Complexity: O(n²)
     */
    func longestPalindrome(_ s: String) -> String {
        let s = Array(s)
        var maxLength = 0
        var palindromeStartIndex = 0
        var dp = [[Bool]].init(repeating: [Bool].init(repeating: false, count: s.count), count: s.count)

        for i in stride(from: s.count - 1, to: -1, by: -1) {
            for j in i..<s.count {
                // Beginning and ending chars should match
                // If window is less than or equal to 3, just end chars should match
                // If window is > 3, substring (i+1, j-1) should be palindrome too
                dp[i][j] = s[i] == s[j] && (j - i < 3 || dp[i + 1][j - 1])

                // Update the maximum length we've seen thus far
                let substringLength = j - i + 1
                if dp[i][j] && substringLength > maxLength {
                    palindromeStartIndex = i
                    maxLength = substringLength
                }
            }
        }

        return String(s[palindromeStartIndex..<palindromeStartIndex + maxLength])
    }

    /**
     Brute force: The obvious brute force solution is to pick all possible starting and ending
     positions for a substring, and verify if it is a palindrome at every step.
     - Complexity: O(n ^ 3)
     */
    func longestPalindromeBruteForce(_ s: String) -> String {
        var maximum = Int.min
        var result: String = ""

        // Scanning through every possible substring takes O(n ^ 2) time
        for i in 0..<s.count {
            for j in i..<s.count {
                let startIndex = s.index(s.startIndex, offsetBy: i)
                let endIndex = s.index(s.startIndex, offsetBy: j)
                let substring = String(s[startIndex...endIndex])

                // Each verification step takes O(n) time
                if isPalindrome(substring) {
                    if substring.count >= maximum {
                        maximum = substring.count
                        result = substring
                    }
                }
            }
        }

        return result
    }

    func isPalindrome(_ s: String) -> Bool {
        func helper(_ s: [Character], _ start: Int, _ end: Int) -> Bool {
            guard (!s.isEmpty || s.count > 1) && start < end else {
                return true
            }

            return s[start] == s[end] && helper(s, start + 1, end - 1)
        }

        // Prune the input
        let unsafeChars = CharacterSet.alphanumerics.inverted
        let input = Array(s.components(separatedBy: unsafeChars).joined(separator: "").lowercased())

        return helper(input, 0, input.count - 1)
    }
}

print(Solution().longestPalindrome("babad"))
print(Solution().longestPalindrome("cbbd"))
