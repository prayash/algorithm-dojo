/**
 Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.

 Input: [0,1,0,3,12]
 Output: [1,3,12,0,0]

 You must do this in-place without making a copy of the array.
 Minimize the total number of operations.
 */

class Solution {
    /**
     Maintain a last-zero seen index with which we overwrite to the first
     partition of the array. Then we'll use that index to fill the rest of
     the array with zeroes.

     - Complexity: O(n) time to do a single pass. O(1) space; it's done in place.
     */
    func moveZeroes(_ nums: inout [Int]) {
        var lastNonZeroIndex = 0

        // If the current element is not 0, then we need to
        // append it just in front of last non 0 element we found.
        for i in 0..<nums.count {
            if nums[i] != 0 {
                nums[lastNonZeroIndex] = nums[i]
                lastNonZeroIndex += 1
            }
        }

        // After we have finished processing new elements,
        // all the non-zero elements are already at beginning of array.
        // We just need to fill remaining array with 0's.
        for i in lastNonZeroIndex..<nums.count {
            nums[i] = 0
        }
    }
}

var x = [0,1,0,3,12]
Solution().moveZeroes(&x)
print(x)
