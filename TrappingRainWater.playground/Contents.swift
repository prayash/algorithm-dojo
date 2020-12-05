/**
 Given n non-negative integers representing an elevation map where the width of
 each bar is 1, compute how much water it is able to trap after raining.

 Input: [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
 Output: 6
 */
class Solution {
    /**
     Two pointers solution: O(n) run-time with O(1) space.
     Maintain two pointers at the edges of the array, moving the left
     forward ONLY if its height is less than the one on the right, because
     then we know that water will get trapped somewhere in between. At each index
     water could get trapped, which will be the tallest building we see minus
     the height of the current building.
     */
    func trap(_ height: [Int]) -> Int {
        var left = 0, right = height.count - 1
        var leftMax = 0, rightMax = 0
        var totalTrapped = 0

        while left < right {
            let leftHeight = height[left]
            let rightHeight = height[right]

            // The height at the current index must be lower than the one on the right
            // Or else water would overflow
            if leftHeight < rightHeight {
                // Update the leftMax with the max height we've seen on the left
                leftMax = max(leftHeight, leftMax)

                // If the current building we're on is smaller than the max height,
                // then that means we've descended and water will get trapped at this index.
                if leftHeight < leftMax {
                    totalTrapped += leftMax - leftHeight
                }

                left += 1
            } else {
                // Update the rightMax with the tallest building we've seen thus far
                rightMax = max(rightHeight, rightMax)

                if rightHeight < rightMax {
                    totalTrapped += rightMax - rightHeight
                }

                right -= 1
            }
        }

        return totalTrapped
    }
}

var input = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
print(Solution().trap(input))

input = [0, 1, 0, 0, 0]
print(Solution().trap(input))

input = [0, 1, 0, 2, 0]
print(Solution().trap(input))

input = [0, 1, 0, 2, 1]
print(Solution().trap(input))
