/**
 Given an integer number n, return the difference between the product of
 its digits and the sum of its digits.

 Input: n = 234
 Output: 15
 Explanation:
 Product of digits = 2 * 3 * 4 = 24
 Sum of digits = 2 + 3 + 4 = 9
 Result = 24 - 9 = 15
 */
class Solution {
    /**
     Take a single pass until we reach 0, extract each digit with modulus.
     - Complexity: O(n) space and time.
     */
    func subtractProductAndSum(_ n: Int) -> Int {
        var product = 1
        var sum = 0
        var num = n

        while num != 0 {
            let digit = num % 10

            product = product * digit
            sum = sum + digit

            num = num / 10
        }

        return product - sum
    }
}

print(Solution().subtractProductAndSum(234))
