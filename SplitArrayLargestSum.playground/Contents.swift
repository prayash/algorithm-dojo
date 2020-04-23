/**
 Given an array which consists of non-negative integers and an integer m, you can split the
 array into m non-empty continuous subarrays. Write an algorithm to minimize the largest sum
 among these m subarrays.

 Note:
 If n is the length of array, assume the following constraints are satisfied:

 1 ≤ n ≤ 1000
 1 ≤ m ≤ min(50, n)
 */

class Solution {
    func splitArray(_ nums: [Int], _ m: Int) -> Int {
        let minimum = nums.max() ?? 0
        let maximum = nums.reduce(0, +)
        var i = minimum
        var j = maximum

        while i < j {
            let potentialSum = (j + i) / 2

            if requiredSplits(potentialSum, nums, m) < m {
                j = potentialSum
            } else {
                i = potentialSum + 1
            }
        }

        return i
    }

    func requiredSplits(_ target: Int, _ nums: [Int], _ m: Int) -> Int {
        var splits = 0
        var currSum = 0

        for number in nums {
            currSum += number
            if currSum > target {
                splits += 1
                currSum = number
            }
        }

        return splits
    }
}

print(Solution().splitArray([7, 2, 5, 10, 8], 2))
