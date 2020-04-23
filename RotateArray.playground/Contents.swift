/**
 Given an array, rotate the array to the right by k steps, where k is non-negative.

 Input: [1,2,3,4,5,6,7] and k = 3 Output: [5,6,7,1,2,3,4]
 Explanation:
 rotate 1 steps to the right: [7,1,2,3,4,5,6]
 rotate 2 steps to the right: [6,7,1,2,3,4,5]
 rotate 3 steps to the right: [5,6,7,1,2,3,4]
 */

class Solution {
    // In-place swap: O(k) time for the number of swaps
    func rotate(_ nums: inout [Int], _ k: Int) {
        func reverse(_ nums: inout [Int], _ start: Int, _ end: Int) {
            var start = start, end = end

            while start < end {
                nums.swapAt(start, end)

                start += 1
                end -= 1
            }
        }

        let k = k % nums.count

        reverse(&nums, 0, nums.count - 1)
        reverse(&nums, 0, k - 1)
        reverse(&nums, k, nums.count - 1)
    }

    // O(n) time and space using an extra array with the recalculated indices
    func rotateWithSpace(_ nums: inout [Int], _ k: Int) {
        var auxiliary = [Int].init(repeating: 0, count: nums.count)

        for i in 0...nums.count - 1 {
            let index = (i + k) % nums.count

            auxiliary[index] = nums[i]
        }

        for i in 0...nums.count - 1 {
            nums[i] = auxiliary[i]
        }
    }
}

var list = [1, 2, 3, 4, 5, 6, 7]
Solution().rotate(&list, 3)
print(list)

var list2 = [0, 6, 9, 4, 2]
Solution().rotateWithSpace(&list2, 2)
print(list2)
