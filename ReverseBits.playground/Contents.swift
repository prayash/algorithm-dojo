/**
 Reverse bits of a given 32 bits unsigned integer.

 Input: 00000010100101000001111010011100
 Output: 00111001011110000010100101000000
 Explanation: The input binary string 00000010100101000001111010011100 represents the
 unsigned integer 43261596, so return 964176192 which its binary representation
 is 00111001011110000010100101000000.
 */

class Solution {
    func reverseBits(_ n: Int) -> Int {
        guard n != 0 else {
            return 0
        }

        var n = n
        var result = 0

        // Iterate from 0 to 31 (32 bits)
        for _ in 0..<32 {
            // Shift result to the left by 1 bit
            result = result << 1

            // If the last digit of input is 1 (verified by AND'ing with 0x1)
            if n & 1 == 1 {
                result += 1
            }

            // Last digit is already taken care of, so drop it by shfting to the right
            n = n >> 1
        }

        return result
    }
}

var n = "101001"
if let binaryN = Int(n, radix: 2) {
    let integer = Solution().reverseBits(binaryN)
    print(String(integer, radix: 2, uppercase: false))
}
