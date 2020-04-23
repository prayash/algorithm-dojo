/**
 Given an integer, write a function to determine if it is a power of two.
 Input: 1
 Output: true
 Explanation: 2^0 = 1

 Input: 16
 Output: true
 Explanation: 24 = 16

 Input: 218
 Output: false
 */

class Solution {
    /**
     O(1) time and space by turning off the least significant bit.
     To subtract 1 means to change the rightmost 1-bit to 0 and to set all the lower bits to 1.
     A power of two will always have 1-bit in the binary form (0x01, 0x10, 0x100, 0x1000).
     x & (x - 1) will set this 1-bit to zero, if it's not a power of two we will have remaining bits!
     */
    func isPowerOfTwo(_ n: Int) -> Bool {
        // 0 can never be a power of 2.
        if n == 0 {
            return false
        }

        // 2 ^ 0 is 1, so yes!
        if n == 1 {
            return true
        }

        return n & (n - 1) == 0
    }
}

print(Solution().isPowerOfTwo(0))
print(Solution().isPowerOfTwo(16))
print(Solution().isPowerOfTwo(218))
