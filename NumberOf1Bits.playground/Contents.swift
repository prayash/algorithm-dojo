/**
 Write a function that takes an unsigned integer and return the number of '1' bits
 it has (also known as the Hamming weight).

 Input: 00000000000000000000000000001011
 Output: 3
 The input binary string 00000000000000000000000000001011 has a total of three '1' bits.
 */

class Solution {
    /**
     Check the i-th bit of a number using a bit mask. Starting with mask = 1.
     A logical AND between any number and the mask gives us the LSB of the number. At each
     iteration, we then shift the mask to the left by one. This is O(n) time and space.
     */
    func hammingWeight(_ n: Int) -> Int {
        var bits = 0
        var mask = 0x01

        for _ in 0..<32 {
            // Check each of the 32 bits of the number. If the bit is 1, we add
            // one to the number of 1-bits.
            if (n & mask) != 0 {
                bits += 1
            }

            mask <<= 1
        }

        return bits
    }

    /**
     Another way of doing this is ANDing the original number with itself - 1.
     Instead of checking every bit of the number, we repeatedly flip the LS 1-bit
     of the number to 0, and add 1 to the sum. As soon as the number becomes 0, we
     know that it does not have any more 1-bits, and we return the sum.
     
     i.e... if n = 1 1 0 1 0 0
     n -1 would be 1 1 0 0 1 1 AND top and bottom would equals
     ............. 1 1 0 0 0 0. So we cancel each 1-bit out until we reach 0.
     */
    func hamming(_ n: Int) -> Int {
        var n = n
        var sum = 0

        while n != 0 {
            n &= (n - 1)
            sum += 1
        }

        return sum
    }
}

var n = 11
print(Solution().hamming(n))
