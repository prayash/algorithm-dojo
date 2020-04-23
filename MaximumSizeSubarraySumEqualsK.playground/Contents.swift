/**
 Given an array nums and a target value k, find the maximum length of a subarray that sums to k.
 If there isn't one, return 0 instead.

 Note:
 The sum of the entire nums array is guaranteed to fit within the 32-bit signed integer range.

 Input: nums = [1, -1, 5, -2, 3], k = 3
 Output: 4
 Explanation: The subarray [1, -1, 5, -2] sums to 3 and is the longest.

 Input: nums = [-2, -1, 2, 1], k = 1
 Output: 2
 Explanation: The subarray [-1, 2] sums to 1 and is the longest.
 */

class Solution {
    /**
     Store all cumulative sums into a hash map. When we run into a situation where
     the difference between the current sum and the target exists in the hash map,
     we know that excluding that element from the hashmap gives us the desired sum.
     */
    func maxSubArrayLen(_ nums: [Int], _ k: Int) -> Int {
        var target = k
        var sum = 0
        var maxLength = 0
        var map = [Int: Int]()

        for i in 0..<nums.count {
            sum += nums[i]

            if sum == target {
                maxLength = i + 1
            } else if let indexOfDiff = map[sum - target] {
                maxLength = max(maxLength, i - indexOfDiff)
            }

            if map[sum] == nil {
                map[sum] = i
            }
        }

        return maxLength
    }
}

//print(Solution().maxSubArrayLen([1, -1, 5, -2, 3], 3))
//print(Solution().maxSubArrayLen([-2, -1, 2, 1], 1))
print(Solution().maxSubArrayLen([1, 2, 2, 3, 4], 7)) // cumulativeSum = [1, 3, 5, 8, 12]
