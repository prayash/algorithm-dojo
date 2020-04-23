/**
 Given an unsigned integer, swap all odd bits with even bits. For example, if the given
 number is 23 (00010111), it should be converted to 43 (00101011). Every even position bit
 is swapped with adjacent bit on right side, and every odd position bit is swapped
 with adjacent on left side.
 */

class Solution {
    func swapAllEvenOddBits(_ n: UInt32) -> UInt32 {
        // Get all even bits of n using 32-bit mask 0x10101010101010101010101010101010
        var evenBits = n & 0xAAAAAAAA

        // Get all odd bits of n using 32-bit mask 0x1010101010101010101010101010101
        var oddBits = n & 0x55555555

        // Shift even bits to the right as specified by the problem
        evenBits >>= 1

        // Shift odd bits to the left
        oddBits <<= 1

        // Combine is as simple as bitwise OR'ing em both
        return evenBits | oddBits
    }
}

print(Solution().swapAllEvenOddBits(23))
print(String(23, radix: 2))
print(String(Solution().swapAllEvenOddBits(23), radix: 2))
