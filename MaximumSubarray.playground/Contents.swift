/**
 Given an integer array nums, find the contiguous subarray (containing at least one number)
 which has the largest sum and return its sum.

 Input: [-2,1,-3,4,-1,2,1,-5,4],
 Output: 6
 Explanation: [4,-1,2,1] has the largest sum = 6.
 */

class Solution {
    /**
     Brute force approach is an O(n^3) solution where we explore all possible subarrays
     and summing them every time using a sliding window. There is a lot of duplicate work being done here.
     */
    func maxSubArrayNaive(_ nums: [Int]) -> Int {
        var maxSum = Int.min

        for left in 0..<nums.count {
            for right in left..<nums.count {
                maxSum = max(nums[left...right].reduce(0, +), maxSum)
            }
        }

        return maxSum
    }

    /**
     O(n ^ 2) time running window summation. We avoid duplicate work by simply adding
     a new value to the windowed sum instead of re-calculating a full sum of the window exery time.
     */
    func maxSubArrayQuadratic(_ nums: [Int]) -> Int {
        var maxSum = Int.min

        for left in 0..<nums.count {
            var windowSum = 0   

            // The sum for the expanding window is the previous sum PLUS the new item!
            for right in left..<nums.count {
                windowSum += nums[right]

                maxSum = max(windowSum, maxSum)
            }
        }

        return maxSum
    }

    /**
     O(n) solution with Kadane's algorithm.
     */
    func maxSubArray(_ nums: [Int]) -> Int {
        var localMax = nums[0], globalMax = nums[0]

        for i in 1..<nums.count {
            localMax = max(nums[i], localMax + nums[i])
            globalMax = max(globalMax, localMax)
        }

        return globalMax
    }

    /**
     O(n) solution while keeping track of the indices.
     */
    func maxSubArrayWithIndices(_ nums: [Int]) -> Int {
        var windowSum = nums[0], globalMax = nums[0]
        var bestStart = 0, bestEnd = 0
        var start = 0

        for i in 1..<nums.count {
            // Start a new sequence at the current element
            if windowSum <= 0 {
                start = i
                windowSum = nums[i]
            } else {
                // Keep extending existing sequence with current element
                windowSum += nums[i]
            }

            if windowSum > globalMax {
                globalMax = windowSum
                bestStart = start
                bestEnd = i
            }
        }

        print(nums[bestStart...bestEnd])

        return globalMax
    }
}

var input = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
print(Solution().maxSubArrayWithIndices(input))
