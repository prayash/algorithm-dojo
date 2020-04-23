/**
 Given a non negative integer number num. For every numbers i in the range 0 ≤ i ≤ num
 calculate the number of 1's in their binary representation and return them as an array.

 Input: 2
 Output: [0,1,1]
 Example 2:

 Input: 5
 Output: [0,1,1,2,1,2]
 Follow up:

 It is very easy to come up with a solution with run time O(n*sizeof(integer)).
 But can you do it in linear time O(n), possibly in a single pass? Space complexity should be O(n).
 */

import simd

class Solution {
    /**
     Use the hamming weight to get the count of set bits for a given integer.
     Loop through the range [0...n] and insert pop counts into the list.
     O(n * k) time where for each integer n, we need O(k) operations where k is the number of bits.
     O(n) space becase we need to store the count results.
     */
    func countBits(_ num: Int) -> [Int] {
        var result = [Int]()

        // Loop through the input range and store hamming weight for each iteration.
        for i in 0...num {
            result.append(popCount(i))
        }

        return result
    }

    /**
     O(n) time and space. Utilize hamming weight but leverage pre-calculated values.
     Last set bit is the rightmost set bit. Setting that bit to zero with the bit
     trick, x &= x - 1, leads to the following transition function:
     P(x) = P(x & (x - 1)) + 1
     */
    func countBitsDP(_ num: Int) -> [Int] {
        var result = Array(repeatElement(0, count: num + 1))

        for i in 1...num {
            result[i] = result[i & (i - 1)] + 1
        }

        return result
    }

    func popCount(_ n: Int) -> Int {
        var count = 0
        var n = n

        // 0 0 1 1
        // 0 0 0 1 &
        // 0 0 0 1

        while n != 0 {
            n &= n - 1 // Zero out the LSB (non-zero)
            count += 1
        }

        return count
    }
}

print(Solution().countBits(2))
print(Solution().countBits(5))
print(Solution().countBitsDP(127))
