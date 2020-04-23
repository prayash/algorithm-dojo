/**
 Given an array of integers, 1 ≤ a[i] ≤ n (n = size of array), some elements appear
 twice and others appear once. Find all the elements that appear twice in this array.

 Input: [4, 3, 2, 7, 8, 2, 3, 1]

 Output: [2, 3]
 */

class Solution {
    /**
     O(n) time and O(1) space, because we encode seen values in-place, taking
     advantage of the constraint 1 ≤ a[i] ≤ n (n = size of array)!
     */
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var nums = nums
        var set = Set<Int>()

        for number in nums {
            // Translate this value into an index.. if we see the same value
            // again, it's going to translate to the same index AGAIN, causing
            // the below condition to evaluate to true, and thus inserting into set.
            let index = abs(number) - 1

            // When we find a number i, flip the number at position i - 1 to negative.
            // If the number at position i - 1 is already negative, i is the number that occurs twice.
            if nums[index] < 0 {
                set.insert(abs(number))
            } else {
                nums[index] = -nums[index]
            }
        }

        return Array(set)
    }
}

var nums = [4, 3, 2, 7, 8, 2, 3, 1]
print(Solution().findDuplicates(nums))

nums = [2, 1, 2, 1]
print(Solution().findDuplicates(nums))

nums = [3, 3, 2]
print(Solution().findDuplicates(nums))
