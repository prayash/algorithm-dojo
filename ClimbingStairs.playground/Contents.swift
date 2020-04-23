/**
 You are climbing a stair case. It takes n steps to reach to the top.
 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
 Note: Given n will be a positive integer.

 Input: 2
 Output: 2
 Explanation: There are two ways to climb to the top.
 1. 1 step + 1 step
 2. 2 steps
 */

class Solution {
    /**
     Intuition behind solution: We are asked, how many ways there are to reach the nth step with the
     ability to climb either 1 or 2 stairs at a time. We can answer this question by first solving smaller
     subproblems like how many ways are there to reach the 3rd step, the 8th step, the nth step. By
     solving smaller subproblems of this large problem, we can create a solution to the original question.

     We start by realizing that there is 1 way to climb 0 steps (don't climb them). We then realize there
     is 1 way to climb 1 step (we climb 1 step. We can't climb two steps because we would miss our
     destination step). We can then iterate through the remaining subproblems, 2 through n and solve the
     ith subproblem by realizing that the number of ways to reach the ith step is the number of ways of
     reaching the i - 1 step plus the number of ways of reaching the i - 2 step (because those are the
     only two stairs we could have come from because we can only climb at most 2 steps). Once we have
     finished our loop, we have solved the number of ways to reach the nth step which is stored in dp[n];
     therefore, we return dp[n].
     */
    func climbStairs(_ n: Int) -> Int {
        if n == 1 || n == 0 { return 1 }

        var dp: [Int] = Array(repeating: 0, count: n + 1)
        dp[0] = 1
        dp[1] = 1

        for i in 2...n {
            dp[i] = dp[i - 1] + dp[i - 2]
        }

        print(dp)

        return dp[n]
    }
}

print(Solution().climbStairs(10))
