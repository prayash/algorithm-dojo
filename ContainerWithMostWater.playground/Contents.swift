/**
 Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai).
 n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two
 lines, which together with x-axis forms a container, such that the container contains the most water.

 Note: You may not slant the container and n is at least 2.
 Input: [1,8,6,2,5,4,8,3,7]
 Output: 49
 */

class Solution {
    /**
     Brute force: Use two loops to calculate every combination of points and store the
     global maximum.
     - Complexity: O(n ^ 2) time and O(1) space
     */
    func maxArea(_ height: [Int]) -> Int {
        var maximum = Int.min

        for i in 0..<height.count {
            for j in i..<height.count {
                let area = (j - i) * min(height[i], height[j])

                maximum = max(area, maximum)
            }
        }

        return maximum
    }

    /**
     Two-pointer approach: We'll start off with two pointers at opposite ends. We'll continually
     calculate the maximum area as we move towards the middle. At any given point,
     we're always bounded by the shorter height, so we'll move that pointer first in order to make the
     wisest next move.
     */
    func maxArea(_ height: [Int], efficient: Bool = true) -> Int {
        var maximum = Int.min

        var i = 0
        var j = height.count - 1

        while i < j {
            maximum = max(maximum, (j - i) * min(height[i], height[j]))

            if height[i] < height[j] {
                i += 1
            } else {
                j -= 1
            }
        }

        return maximum
    }
}

print(Solution().maxArea([1,8,6,2,5,4,8,3,7]))
print(Solution().maxArea([1,8,6,2,5,4,8,3,7], efficient: true))
