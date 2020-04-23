/**
 A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).

 The robot can only move either down or right at any point in time. The robot is trying to reach
 the bottom-right corner of the grid (marked 'Finish' in the diagram below).

 How many possible unique paths are there?

 Input: m = 3, n = 2
 Output: 3
 Explanation:
 From the top-left corner, there are a total of 3 ways to reach the bottom-right corner:
 1. Right -> Right -> Down
 2. Right -> Down -> Right
 3. Down -> Right -> Right
 */

class Solution {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var table: [[Int]] = [[Int]].init(repeating: [Int].init(repeating: 0, count: n), count: m)

        for i in 0..<table.count {
            table[i][0] = 1
        }

        for i in 0..<n {
            table[0][i] = 1
        }

        for i in 1..<table.count {
            for j in 1..<table[i].count {
                table[i][j] = table[i - 1][j] + table[i][j - 1]
            }
        }

        print(table)

        return table[m - 1][n - 1]
    }
}

print(Solution().uniquePaths(3, 2))
