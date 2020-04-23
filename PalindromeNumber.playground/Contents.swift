/**
 Determine whether an integer is a palindrome. An integer is a palindrome when it reads the same backward as forward.
 */

class Solution {
    func isPalindrome(_ x: Int) -> Bool {
        guard x >= 0 else {
            return false
        }

        if x % 10 == 0 && x != 0 {
            return false
        }

        var x = x
        var revertedNumber = 0
        while x > revertedNumber {
            revertedNumber = revertedNumber * 10 + x % 10
            x = x / 10
        }

        return x == revertedNumber || x == revertedNumber / 10
    }
}

print(Solution().isPalindrome(-121))
print(Solution().isPalindrome(121))
