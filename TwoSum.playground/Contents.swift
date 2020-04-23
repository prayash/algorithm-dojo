/**
 Given an array of integers, return indices of the two numbers such that they add up to a specific target.
 You may assume that each input would have exactly one solution, and you may not use the same element twice.

 Example:
 Given nums = [2, 7, 11, 15], target = 9,
 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].

 This solution takes O(n) where n is the number of digits in the input array
 */

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // Allocate a map to keep track of the numbers we have
        var map: [Int: Int] = [:]

        for i in 0..<nums.count {
            let complement = target - nums[i]

            // If the complement exists in the map, we're good.
            if let index = map[complement] {
                return [index, i]
            }

            map[nums[i]] = i
        }

        // No matches
        return []
    }
}

let x = [2, 7, 11, 15]
let target = 9

print(Solution().twoSum(x, target))
