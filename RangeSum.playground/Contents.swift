/**
 Given an integer array nums, find the sum of the elements between indices i and j (i ≤ j), inclusive.

 Example:
 Given nums = [-2, 0, 3, -5, 2, -1]

 sumRange(0, 2) -> 1
 sumRange(2, 5) -> -1
 sumRange(0, 5) -> -3
 */

class NumArray {
    var memo: [Int] = []

    init(_ nums: [Int]) {
        guard nums.count > 0 else { return }

        // Initialization memoization table
        memo = [Int].init(repeating: 0, count: nums.count)
        memo[0] = nums[0]

        for i in 1..<memo.count {
            memo[i] = memo[i - 1] + nums[i]
        }
    }

    /**
     Brute force approach is very simple, use a for-loop to sum each individial from index i to j.
     This is an O(n) approach which isn't very efficient. A better approach would be to use DP.
     We pre-compute the sum from index 0 to n and store in P. Then range sum could then be accessed
     by returning P[j] - P[i - 1]
     - Complexity: O(n) time and space for pre-computing, O(1) queries.
     */
    func sumRange(_ i: Int, _ j: Int) -> Int {
        if i == 0 {
            return memo[j]
        }

        return memo[j] - memo[i - 1]
    }
}

/**
 * Your NumArray object will be instantiated and called as such:
 * let obj = NumArray(nums)
 * let ret_1: Int = obj.sumRange(i, j)
 */

let obj = NumArray([-2, 0, 3, -5, 2, -1])
print(obj.sumRange(1, 3))
print(obj.memo)
