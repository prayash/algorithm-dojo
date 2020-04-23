/**
 Given an array nums of n integers where n > 1,  return an array output such
 that output[i] is equal to the product of all the elements of nums except nums[i].

 Input:  [1,2,3,4]
 Output: [24,12,8,6]
 */

class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        guard nums.count > 1 else { return nums }

        var result = Array(repeating: 1, count: nums.count)

        var leftMultiplier = 1
        for i in 0..<nums.count {
            result[i] *= leftMultiplier
            leftMultiplier *= nums[i]
        }

        print(result)

        var rightMultiplier = 1
        for i in stride(from: nums.count-1, through: 0, by: -1) {
            result[i] *= rightMultiplier
            rightMultiplier *= nums[i]
        }

        return result
    }
}

print(Solution().productExceptSelf([2, 3, 4, 5]))

/**
 i = 0, mult = 2 * 3 * 4
 result = [1 * 1, 2, 6, 24]


i = 3, mult = 4
 result = [1, 2, 30, 24]

 */
