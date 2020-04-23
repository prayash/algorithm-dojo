/**
 Given a non-empty string s, you may delete at most one character. Judge whether you can make it a palindrome.

 Input: "abca"
 Output: True
 Explanation: You could delete the character 'c'.
 */
class Solution {
    func isPalindrome(_ s: String) -> Bool {
        var i = 0
        var j = s.count - 1
        let s = Array(s)

        while i < j {
            if s[i] != s[j] {
                return false
            }

            i += 1
            j -= 1
        }

        return true
    }

    func validPalindrome(_ s: String) -> Bool {
        guard !s.isEmpty else {
            return true
        }

        var start = s.startIndex
        var end = s.index(before: s.endIndex)

        while start < end {
            if s[start] != s[end] {
                // If removing s[end] makes the whole string palindrome.
                // We basically check if substring s[start...end - 1] is
                // palindrome or not.
                let stringBeforeMismatch = String(s[start...s.index(before: end)])

                // If removing s[start] makes the whole string palindrome.
                // We basically check if substring s[start + 1..end] is
                // palindrome or not.
                let stringAfterMismatch = String(s[s.index(after: start)...end])

                if isPalindrome(stringBeforeMismatch) || isPalindrome(stringAfterMismatch) {
                    return true
                }

                return false
            }

            start = s.index(after: start)
            end = s.index(before: end)
        }

        return true
    }
}

print(Solution().validPalindrome("racercar"))
