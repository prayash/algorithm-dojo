/**
 Given two integers dividend and divisor, divide two integers without using
 multiplication, division and mod operator.
 Return the quotient after dividing dividend by divisor.
 The integer division should truncate toward zero.

 Both dividend and divisor will be 32-bit signed integers. The divisor will never be 0.
 Assume we are dealing with an environment which could only store integers within
 the 32-bit signed integer range: [−2^31,  2^31 − 1]. For the purpose of this
 problem, assume that your function returns 2^31 − 1 when the division result overflows.

 Input: dividend = 10, divisor = 3
 Output: 3

 Input: dividend = 7, divisor = -3
 Output: -2
 */

class Solution {
    /**
     The key observation is that the quotient of a division is just the number of times
     that we can subtract the divisor from the dividend without making it negative.
     O(log n * log n) time. The inner while loop is logn, and because the dividend gets
     by at least half, the outer loop is gonna take log n as well. O(1) space.
     */
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        if dividend == Int32.min && divisor == -1 {
            return Int(Int32.max)
        }

        let isPositive = (dividend > 0) == (divisor > 0)
        var a = abs(dividend)
        let b = abs(divisor)
        var result = 0

        // Can we take the divisor away from the dividend at least once?
        while a - b >= 0 {
            var x = 0
            let divisorTimesTwo = b << 1

            // How many times can we shift to the left (double the value)
            // until we exceed the dividend?
            while a - (divisorTimesTwo << x) >= 0 {
                x += 1
            }

            // How many times can we double the divisor without exceeding it?
            // This is forming the quotient.
            result += 1 << x

            // Take away from the dividend how many times we've doubled the divisor.
            // This is essentially the remainder.
            a -= b << x
        }

        return isPositive ? result : -result
    }
}

print(Solution().divide(10, 3))
print(Solution().divide(7, -3))
