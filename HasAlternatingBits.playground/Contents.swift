/**
 Given a positive integer, check whether it has alternating bits: namely, if two adjacent bits
 will always have different values.

 Input: 5
 Output: True
 Explanation:
 The binary representation of 5 is: 101

 Input: 7
 Output: False
 Explanation:
 The binary representation of 7 is: 111.
 */

class Solution {
    /**
        n =             1 0 1 0 1 0 1 0
        n >> 1          0 1 0 1 0 1 0 1
        n ^ n>>1        1 1 1 1 1 1 1 1     XOR n with itself shifted by 1 to turn it all into 1's
        n               1 1 1 1 1 1 1 1
        n + 1     1     0 0 0 0 0 0 0 0     ADD 1 to make all 1's 0's with a 1 at MSB
        n & (n + 1)     0 0 0 0 0 0 0 0     AND with itself + 1 to attempt to turn into all 0's
    */
    func hasAlternatingBits(_ n: Int) -> Bool {
        var n = n

        // XOR with 1-bit shifted version to turn the number into all ones
        n = n ^ (n << 1)

        // (n + 1) will turn all 1-bits into 0, and add 1 as MSB which we don't really need
        // XOR'ing that with n + 1 will make it all 0's ONLY if it has alternating bits!
        return (n & (n + 1)) == 0
    }
}

print(Solution().hasAlternatingBits(5))
print(Solution().hasAlternatingBits(11))
