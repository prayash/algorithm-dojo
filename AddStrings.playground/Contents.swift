/**
 Given two non-negative integers num1 and num2 represented as string, return the sum of num1 and num2.

 The length of both num1 and num2 is LT 5100.
 Both num1 and num2 contains only digits 0-9.
 Both num1 and num2 does not contain any leading zero.
 You must not use any built-in BigInteger library or convert the inputs to integer directly.
 */

class Solution {
    func addStrings(_ num1: String, _ num2: String) -> String {
        let s1 = num1.unicodeScalars.map { String($0) }
        let s2 = num2.unicodeScalars.map { String($0) }
        var i = num1.count - 1
        var j = num2.count - 1
        var result = ""
        var carry = 0

        while i >= 0 || j >= 0 {
            // Let's assume 0 as a fallback if one of the indices finishes processing!
            let num1 = i >= 0 ? Int(s1[i])! : 0
            let num2 = j >= 0 ? Int(s2[j])! : 0

            // Always account for the carry-over
            let sum = num1 + num2 + carry

            // Carry will be the remaining integer from this division op
            carry = sum / 10

            // Concat the sum
            result = "\(sum % 10)\(result)"

            i -= 1
            j -= 1
        }

        // Can't forget the final potential carry
        if carry > 0 {
            result = "\(carry)\(result)"
        }

        return result
    }
}

print(Solution().addStrings("1928", "1975")) // 3903
