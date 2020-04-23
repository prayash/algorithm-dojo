/**
 Given an array with n objects colored red, white or blue, sort them in-place so that objects of
 the same color are adjacent, with the colors in the order red, white and blue.

 Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.
 Note: You are not suppose to use the library's sort function for this problem

 Input: [2,0,2,1,1,0]
 Output: [0,0,1,1,2,2]

 Follow up:
 A rather straight forward solution is a two-pass algorithm using counting sort.
 First, iterate the array counting number of 0's, 1's, and 2's, then overwrite array with total
 number of 0's, then 1's and followed by 2's.
 Could you come up with a one-pass algorithm using only constant space?
 */

class Solution {
    // O(n) single pass solution using a 3-way partitioning
    func sortColors(_ nums: inout [Int]) {
        guard !nums.isEmpty || nums.count > 1 else {
            return
        }

        var start = 0
        var end = nums.count - 1
        var index = 0

        while index <= end && start < end {
            // The start index always sits at the beginning of the array until we see a 0
            if nums[index] == 0 {
                nums.swapAt(index, start)

                start += 1
                index += 1
            } else if nums[index] == 2 {
                // The ending index will sit at the end, and will move down when we see a 2
                nums.swapAt(index, end)
                end -= 1
            } else {
                index += 1
            }
        }
    }

    // Two-pass solution using counting-sort. Still O(n)!
    func sortColorsTwoPass(_ nums: inout [Int]) {
        var count = [Int].init(repeating: 0, count: 3)

        // Count the instances
        nums.forEach {
            count[$0] += 1
        }

        // Sort the final collection
        var index = 0
        for i in 0...2 {
            for _ in 0..<count[i] {
                nums[index] = i
                index += 1
            }
        }
    }
}

var input = [2, 0, 2, 1, 1, 0]
Solution().sortColorsTwoPass(&input)
print(input)
