/**
 Given an unsorted array of integers, find the length of longest continuous increasing subsequence (subarray).

 Example 1:
 Input: [1,3,5,4,7]
 Output: 3
 Explanation: The longest continuous increasing subsequence is [1,3,5], its length is 3.
 Even though [1,3,5,7] is also an increasing subsequence, it's not a continuous one where 5 and 7 are separated by 4.
 Example 2:
 Input: [2,2,2,2,2]
 Output: 1
 Explanation: The longest continuous increasing subsequence is [2], its length is 1.
 */

class Solution {
    func findLengthOfLCIS(_ nums: [Int]) -> Int {
        var length = 0
        var anchor = 0

        for i in 0..<nums.count {
            if i > 0 && nums[i - 1] >= nums[i] {
                anchor = i
            }

            length = max(length, i - anchor + 1)
        }

        return length
    }
}

print(Solution().findLengthOfLCIS([1, 3, 5, 4, 7]))
print(Solution().findLengthOfLCIS([2, 2, 2, 2, 2]))
