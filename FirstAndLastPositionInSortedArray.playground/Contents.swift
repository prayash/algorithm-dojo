/**
 Given an array of integers nums sorted in ascending order, find the starting and ending position of a given target value.

 Your algorithm's runtime complexity must be in the order of O(log n).
 If the target is not found in the array, return [-1, -1].

 Example 1:

 Input: nums = [5,7,7,8,8,10], target = 8
 Output: [3,4]
 Example 2:

 Input: nums = [5,7,7,8,8,10], target = 6
 Output: [-1,-1]
 */
class Solution {
    enum Direction {
        case left, right
    }

    private func findEdge(_ nums: [Int], _ target: Int, _ d: Direction) -> Int {
        var i = 0
        var j = nums.count

        while i < j {
            let mid = i + (j - i) / 2

            if nums[mid] > target || d == .left && target == nums[mid] {
                j = mid
            } else {
                i = mid + 1
            }
        }

        return i
    }

    /**
     We'll use two binary searches: one to the find the left edge, the other to find the right.
     - Complexity: O(log n) time, O(1) space.
     */
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        var result = [-1, -1]
        let leftIdx = findEdge(nums, target, .left)

        // If we don't find the target, then return.
        if leftIdx == nums.count || nums[leftIdx] != target {
            return result
        }

        result[0] = leftIdx
        result[1] = findEdge(nums, target, .right) - 1

        return result
    }
}

print(Solution().searchRange([5,7,7,8,8,10], 6))
print(Solution().searchRange([5,7,7,8,8,10], 8))
print(Solution().searchRange([1], 1))
