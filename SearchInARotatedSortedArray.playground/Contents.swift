/**
 Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

 (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).

 You are given a target value to search. If found in the array return its index, otherwise return -1.

 You may assume no duplicate exists in the array.

 Your algorithm's runtime complexity must be in the order of O(log n).

 Example 1:

 Input: nums = [4,5,6,7,0,1,2], target = 0
 Output: 4
 Example 2:

 Input: nums = [4,5,6,7,0,1,2], target = 3
 Output: -1
 */

class Solution {
    /**
     Nested binary search.
     - Complexity: O(log n) time and O(1) space.
     */
    func search(_ nums: [Int], _ target: Int) -> Int {
        var i = 0
        var k = nums.count - 1

        while i <= k {
            let j = i + (k - i) / 2

            if nums[j] == target {
                return j
            } else if nums[j] >= nums[i] {
                if target >= nums[i] && target < nums[j] {
                    k = j - 1
                } else {
                    i = j + 1
                }
            } else {
                if target > nums[j] && target <= nums[k] {
                    i = j + 1
                } else {
                    k = j - 1
                }
            }
        }

        return -1
    }
}

print(Solution().search([4,5,6,7,0,1,2], 0))
print(Solution().search([4,5,6,7,0,1,2], 3))
