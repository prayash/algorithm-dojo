/**
 Given an array nums of integers, a move consists of choosing any element and decreasing it by 1.
 An array A is a zigzag array if either:
 Every even-indexed element is greater than adjacent elements, ie. A[0] > A[1] < A[2] > A[3] < A[4] > ...
 OR, every odd-indexed element is greater than adjacent elements, ie. A[0] < A[1] > A[2] < A[3] > A[4] < ...
 Return the minimum number of moves to transform the given array nums into a zigzag array.

 Example 1:
 Input: nums = [1,2,3]
 Output: 2
 Explanation: We can decrease 2 to 0 or 3 to 1.
 */
class Solution {
    func movesToMakeZigzag(_ nums: [Int]) -> Int {
        var res = [Int].init(repeating: 0, count: 2)
        var left = 0, right = 0

        for i in 0..<nums.count {
            left = i > 0 ? nums[i - 1] : 1001
            right = i + 1 < nums.count ? nums[i + 1] : 1001
            res[i % 2] += max(0, nums[i] - min(left, right) + 1)
        }

        return min(res[0], res[1])
    }
}

print(Solution().movesToMakeZigzag([9, 6, 1, 6, 2]))
