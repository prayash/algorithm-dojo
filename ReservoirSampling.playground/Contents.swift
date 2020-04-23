/**
 Given an array of integers with possible duplicates, randomly output the index of a given target number.
 You can assume that the given target number must exist in the array.
 The array size can be very large. Solution that uses too much extra space will not pass the judge.

 int[] nums = new int[] {1,2,3,3,3};
 Solution solution = new Solution(nums);

 // pick(3) should return either index 2, 3, or 4 randomly. Each index should have equal probability of returning.
 solution.pick(3);

 // pick(1) should return 0. Since in the array only nums[0] is equal to 1.
 solution.pick(1);
 */
class Solution {
    let nums: [Int]

    init(_ nums: [Int]) {
        self.nums = nums
    }

    /**
     Reservoir sampling: As we count the target number in the stream, we increment the total
     count, decreasing the probability with random[0..<count] 
     */
    func pick(_ target: Int) -> Int {
        var total = 0
        var index = -1

        for i in 0..<nums.count {
            if nums[i] != target {
                continue
            }

            total += 1

            // As we count our target number, the probability decreases progressively
            // from 1/1 to 1/2 to 1/3
            if Int.random(in: 0..<total) == 0 {
                index = i
            }
        }

        return index
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(nums)
 * let ret_1: Int = obj.pick(target)
 */

let obj = Solution([1,2,3,3,3])
print(obj.pick(3))
