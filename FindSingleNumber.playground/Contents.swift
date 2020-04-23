/**
 Given a non-empty array of integers, every element appears three times except for one,
 which appears exactly once. Find that single one.
 Your algorithm should have a linear runtime complexity.
 Could you implement it without using extra memory?

 Input: [2,2,3,2]
 Output: 3

 Input: [0,1,0,1,0,1,99]
 Output: 99
 */

class Solution {
    /**
     O(n) time and space. Iterate over the collection and maintain a count using a dictionary.
     */
    func findSingleNumber(_ nums: [Int]) -> Int {
        var hashMap: [Int: Int] = [:]

        for number in nums {
            if hashMap[number] != nil {
                hashMap[number]! += 1
            } else {
                hashMap[number] = 1
            }
        }

        for (key, value) in hashMap {
            if value == 1 {
                return key
            }
        }

        return -1
    }

    /**
     Bitwise operators for O(1) space.
     */
    func findSingleNumberBitwise(_ nums: [Int]) -> Int {
        // Holds XOR of all the elements which have appeared once.
        var ones = 0x00000000

        // Holds XOR of all the elements which have appeared twice.
        var twos = 0x00000000

        /**
         At any point in time,
         A new number appears - It gets XOR'd to the variable "ones".
         A number gets repeated (appears twice) - It is removed from "ones" and XOR'd to the
         variable "twos".
         A number appears for the third time - It gets removed from both "ones" and "twos".
         */
        for num in nums {
            // Add A[i] to the set "ones" if and only if its not there in set "twos". If it is,
            // then remove it from "ones"
            ones = (ones ^ num) & ~twos

            // Similarly, only add nums[i] to "twos" if it's not already in ones
            twos = (twos ^ num) & ~ones
        }

        return ones
    }
}

print(Solution().findSingleNumberBitwise([0, 1, 0, 1, 0, 1, 99]))
