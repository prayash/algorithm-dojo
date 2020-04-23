/**
 Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.
 (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).

 You are given a target value to search. If found in the array return its index, otherwise return -1.
 You may assume no duplicate exists in the array.
 Your algorithm's runtime complexity must be in the order of O(log n).

 Input: nums = [4,5,6,7,0,1,2], target = 0
 Output: 4
 */

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var start = 0
        var end = nums.count - 1

        // Perform standard binary search
        while start <= end {
            let mid = start + (end - start) / 2

            // If we find the target, we're good
            if nums[mid] == target {
                return mid

            // If the pivot element is larger than the first element in the array
            } else if nums[mid] >= nums[start] {
                // If the target is in that non-rotated part as well
                if target >= nums[start] && target < nums[mid] {
                    end = mid - 1
                } else {
                    start = mid + 1
                }
            // Pivot eleement is smaller than the
            } else {
                if target <= nums[end] && target > nums[mid] {
                    start = mid + 1
                } else {
                    end = mid - 1
                }
            }
        }

        return -1
    }
}

print(Solution().search([4, 5, 6, 7, 0, 1, 2], 0))
