/**
 Given an array nums of n integers, are there elements a, b, c in nums such
 that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.
 Note:
 The solution set must not contain duplicate triplets.

 Given array nums = [-1, 0, 1, 2, -1, -4], -> [-4, -1, -1, 0, 2, 3] (sorted)

 A solution set is:
 [
   [-1, 0, 1],
   [-1, -1, 2]
 ]
 */

class Solution {
    /**
     - Complexity: O(n ^ 2) time and O(n) space.
     */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count >= 3 else { return [[Int]]() }

        let sorted = nums.sorted()
        var result = [[Int]]()

        for i in 0..<sorted.count {
            // Don't allow `i` to point to same element
            if i != 0, sorted[i] == sorted[i - 1] { continue }

            var low = i + 1
            var high = sorted.count - 1

            while low < high {
                let sum = sorted[i] + sorted[low] + sorted[high]

                if sum == 0 {
                    result.append([sorted[i], sorted[low], sorted[high]])
                    low += 1

                    // Don't allow `low` to point to same element
                    while low < high, sorted[low] == sorted[low - 1] {
                        low += 1
                    }
                } else if sum < 0 {
                    // Since the list is sorted, a negative sum would mean that we need
                    // to increment the lower bound to get closer to 0
                    low += 1
                } else {
                    // If the sum is greater than 0, a positive sum would mean that we need
                    // to decrement our upper bound to move closer to 0
                    high -= 1
                }
            }
        }

        return result
    }
}

print(Solution().threeSum([-1, 0, 1, 2, -1, -4]))
print(Solution().threeSum([0, 0, 0, 0]))
