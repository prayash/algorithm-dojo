/**
 Given a sorted array A of unique numbers, find the K-th missing number starting from the leftmost number of the array.

     Example 1:

     Input: A = [4,7,9,10], K = 1
     Output: 5
     Explanation:
     The first missing number is 5.
     Example 2:

     Input: A = [4,7,9,10], K = 3
     Output: 8
     Explanation:
     The missing numbers are [5,6,8,...], hence the third missing number is 8.
     Example 3:

     Input: A = [1,2,4], K = 3
     Output: 6
     Explanation:
     The missing numbers are [3,5,6,7,...], hence the third missing number is 6.
 */
class Solution {
    func missingElement(_ nums: [Int], _ k: Int) -> Int {
        func missing(_ index: Int) -> Int {
            return nums[index] - nums[0] - index
        }

        let n = nums.count

        if k > missing(n - 1) {
            return nums[n - 1] + k - missing(n - 1)
        }

        var idx = 1
        while missing(idx) < k {
            idx += 1
        }

        return nums[idx - 1] + k - missing(idx - 1)
    }
}

print(Solution().missingElement([4, 7, 9, 10], 3))
