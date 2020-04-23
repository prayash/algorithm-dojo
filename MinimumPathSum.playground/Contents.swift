/**
 Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right
 which minimizes the sum of all numbers along its path.

 Note: You can only move either down or right at any point in time.

 Example:

 Input:
 [
   [1,3,1],
   [1,5,1],
   [4,2,1]
 ]
 Output: 7
 Explanation: Because the path 1→3→1→1→1 minimizes the sum.
 */

class Solution {
    /**
     Naive recursive method.
     - Complexity: O(2 ^ m + n)
     */
    func minPathSum(_ grid: [[Int]]) -> Int {
        func helper(_ i: Int, _ j: Int) -> Int {
            if i == grid.count || j == grid.count { return Int(Int.max) }

            if i == grid.count - 1 && j == grid.count - 1 {
                return grid[i][j]
            }

            return grid[i][j] + min(helper(i + 1, j), helper(i, j + 1))
        }

        return helper(0, 0)
    }

    /**
     DP Table.
     - Complexity: O(mn) time and O(mn) space.
     */
    func minPathSumDP(_ grid: [[Int]]) -> Int {
        var dp = [[Int]].init(repeating: [Int].init(repeating: 0, count: grid[0].count), count: grid.count)
        for i in stride(from: grid.count - 1, to: -1, by: -1) {
            for j in stride(from: grid[0].count - 1, to: -1, by: -1) {
                // Grab the right + current val
                if i == grid.count - 1 && j != grid[i].count - 1 {
                    dp[i][j] = grid[i][j] + dp[i][j + 1]
                } else if j == grid[i].count - 1 && i != grid.count - 1 {
                    // Grab the below + current val
                    dp[i][j] = grid[i][j] + dp[i + 1][j]
                } else if j != grid[i].count - 1 && i != grid.count - 1 {
                    // Grab the current + the min of either the right or the one below
                    dp[i][j] = grid[i][j] + min(dp[i + 1][j], dp[i][j + 1])
                } else {
                    // Grab the very first val
                    dp[i][j] = grid[i][j]
                }
            }
        }

        return dp[0][0]
    }
}

print(Solution().minPathSumDP([
  [1,3,1],
  [1,5,1],
  [4,2,1]
]))

print(Solution().minPathSumDP([
  [1, 3, 4, 8],
  [3, 2, 2, 4],
  [5, 7, 1, 9],
  [2, 3, 2, 3]
]))
