/**
 Given a binary array, find the maximum number of consecutive 1s in this array.

 Input: [1, 1, 0, 1, 1, 1]
 Output: 3
 Explanation: The first two digits or the last three digits are consecutive 1s.
 The maximum number of consecutive 1s is 3.
 */

class Solution {
    /**
     O(n) time and O(1) space. Take a single pass through and update
     our maximum with what we've seen so far in a greedy fashion.
     */
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        var maximum = 0
        var count = 0

        for number in nums {
            if number == 1 {
                count += 1
            } else {
                // Update our maximum with what we've seen so far
                maximum = max(maximum, count)

                // Reset the counter!
                count = 0
            }
        }

        // Consider the final pass we took and return the max of that
        return max(maximum, count)
    }
}

var nums = [1, 1, 0, 1, 1, 1]
print(Solution().findMaxConsecutiveOnes(nums))
