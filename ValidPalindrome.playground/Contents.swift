import Foundation

/**
 Given a string, determine if it is a palindrome, considering only alphanumeric
 characters and ignoring cases.

 Note: For the purpose of this problem, we define empty string as valid palindrome.
 */

class Solution {

    // MARK: - O(n) solution 😎

    /**
     O(n) time to scan through the whole thing with two pointers.
     O(n) space to store an array without the alphanumeric characters.
     */
    func isPalindrome(_ s: String) -> Bool {
        guard !s.isEmpty || s.count > 1 else {
            return true
        }

        // Prune the input
        let unsafeChars = CharacterSet.alphanumerics.inverted
        let input = Array(s.components(separatedBy: unsafeChars).joined(separator: "").lowercased())

        var i = 0
        var j = input.count - 1

        while i < j {
            if input[i] != input[j] {
                return false
            }

            i += 1
            j -= 1
        }

        return true
    }

    // MARK: - O(n) with recursion. Careful with potential stack overflows!

    func isPalindromeRecursive(_ s: String) -> Bool {
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

print(Solution().isPalindrome("A man, a plan, a canal: Panama"))
print(Solution().isPalindrome("race a car"))
print(Solution().isPalindromeRecursive("A man, a plan, a canal: Panama"))
print(Solution().isPalindromeRecursive("race a car"))
