/**
 Given an integer, write a function to determine if it is a power of three.
 Avoid looping or recursion.

 Input: 27
 Output: true
 */

import Foundation

class Solution {
    func isPowerOfThreeNaive(_ n: Int) -> Bool {
        var n = n

        if n < 1 {
            return false
        }

        while n % 3 == 0 {
            n /= 3
        }

        return n == 1
    }

    func isPowerOfThree(_ n: Int) -> Bool {
        // 1162261467=3^19. 3^20 is bigger than Int32.max
        return n > 0 && n <= Int32.max && 1162261467 % n == 0
    }
}

print(Solution().isPowerOfThree(19))
