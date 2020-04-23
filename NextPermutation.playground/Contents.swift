/**
 Implement next permutation, which rearranges numbers into the lexicographically next greater permutation
 of numbers. If such arrangement is not possible, it must rearrange it as the lowest possible
 order (ie, sorted in ascending order).

 The replacement must be in-place and use only constant extra memory.
 Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in the
 right-hand column.

 1,2,3 → 1,3,2
 3,2,1 → 1,2,3
 1,1,5 → 1,5,1
 */

class Solution {
    /**
     Single pass approach: For any given sequence that is in descending order, no next larger
     permutation is possible. The requirements of in-place replacement and constant space should
     immediately indicate swapping.If the elements are increasing, they are currently at their
     largest possible permutation, so nothing can be done.
     - Complexity: O(n) time and O(1) space
     */
    func nextPermutation(_ nums: inout [Int]) {
        guard nums.count > 1 else { return }

        // Work backwards to find the decreasing element
        var i = nums.count - 2
        while i >= 0 && nums[i + 1] <= nums[i] {
            i -= 1
        }

        if i >= 0 {
            // Work backwards again to find the number bigger than the one stored at i
            var j = nums.count - 1
            while j >= 0 && nums[j] <= nums[i] {
                j -= 1
            }

            // Swap the two values
            nums.swapAt(i, j)
        }

        // Reverse the remainder
        reverse(&nums, i + 1)
    }

    private func reverse(_ nums: inout [Int], _ start: Int) {
        var i = start
        var j = nums.count - 1

        while i < j {
            nums.swapAt(i, j)
            i += 1
            j -= 1
        }
    }
}

var nums = [1, 2, 3]
Solution().nextPermutation(&nums)
print("[1, 2, 3] ->", nums)

nums = [3, 2, 1]
Solution().nextPermutation(&nums)
print("[3, 2, 1] ->", nums)

nums = [1, 1, 5]
Solution().nextPermutation(&nums)
print("[1, 1, 5] ->", nums)

nums = [1, 5, 8, 4, 7, 6, 5, 3, 1]
Solution().nextPermutation(&nums)
print("[1, 5, 8, 4, 7, 6, 5, 3, 1] ->", nums)
