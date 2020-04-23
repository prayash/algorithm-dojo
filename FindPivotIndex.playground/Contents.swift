/**
 Given an array of integers nums, write a method that returns the "pivot" index of this array.

 We define the pivot index as the index where the sum of the numbers to the left of the
 index is equal to the sum of the numbers to the right of the index.

 If no such index exists, we should return -1. If there are multiple pivot indexes, you
 should return the left-most pivot index.

 Input:
 nums = [1, 7, 3, 6, 5, 6]
 Output: 3
 Explanation:
 The sum of the numbers to the left of index 3 (nums[3] = 6) is equal to the sum of
 numbers to the right of index 3.
 Also, 3 is the first index where this occurs.
 */

/**
 O(n) time and O(1) space. We have to take a single pass at the very least.
 */
class Solution {
    func pivotIndex(_ nums: [Int]) -> Int {
        var leftSum: Int = 0
        let sum: Int = nums.reduce(0) { $0 + $1 }

        for i in 0..<nums.count {
            let rightSideSum = sum - leftSum - nums[i]

            if leftSum == rightSideSum {
                return i
            }

            leftSum += nums[i]
        }

        return -1
    }
}

print(Solution().pivotIndex([1, 7, 3, 6, 5, 6]))
