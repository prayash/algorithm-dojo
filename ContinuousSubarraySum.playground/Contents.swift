/**
 Given a list of non-negative numbers and a target integer k, write a function to check if the
 array has a continuous subarray of size at least 2 that sums up to a multiple of k, that is, sums
 up to n*k where n is also an integer.

 Input: [23, 2, 4, 6, 7],  k=6
 Output: True
 Explanation: Because [2, 4] is a continuous subarray of size 2 and sums up to 6.
 */
class Solution {
    /**
     Brute force.
     - Complexity: O(n ^ 3)
     */
    func checkSubarraySumNaive(_ nums: [Int], _ k: Int) -> Bool {
        for i in 0..<nums.count - 1 {
            for j in i + 1..<nums.count {
                let sum = nums[i...j].reduce(0, +)

                if sum == k || (k != 0 && sum % k == 0) {
                    return true
                }
            }
        }

        return false
    }

    /**
     The main idea is that (x + n * k) mod k = x ,which x can be 0, 1, ..., k - 1.
     We iterate through the input array exactly once, keeping track of the running sum % k of
     the elements in the process. If we find that a running sum value at index j has been
     previously seen before in some earlier index i in the array, then we know that
     the sub-array (i, j] contains a desired sum.
     */
    func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
        var map: [Int: Int] = [0: -1]
        var runningSum = 0

        for i in 0..<nums.count {
            runningSum += nums[i]

            if k != 0 {
                runningSum %= k
            }

            if let prev = map[runningSum] {
                if i - prev > 1 {
                    return true
                }
            } else {
                map[runningSum] = i
            }
        }

        return false
    }
}

print(Solution().checkSubarraySum([23, 2, 4, 6, 7], 6))
