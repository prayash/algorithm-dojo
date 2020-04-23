/**
 Given a positive integer n, break it into the sum of at least two positive integers and maximize the product of those integers. Return the maximum product you can get.

 Input: 2
 Output: 1
 Explanation: 2 = 1 + 1, 1 × 1 = 1.

 Input: 10
 Output: 36
 Explanation: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36.
 */

class Solution {
    /**
     For an integer i, we define a dynamic programming state dp[i] which indicates the
     maximum product you can get for integers that sum up to i.
     */
    func integerBreak(_ n: Int) -> Int {
        var memo = [Int](repeatElement(0, count: n + 1))

        memo[1] = 1

        for i in 2...n {
            for j in 1..<i {
                let potential = max(j, memo[j]) * (i - j)

                memo[i] = max(memo[i], potential)
            }
        }

        print(memo)

        return memo[n]
    }
}

print(Solution().integerBreak(10))
