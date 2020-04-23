/**
 In a gold mine grid of size m * n, each cell in this mine has an integer representing
 the amount of gold in that cell, 0 if it is empty.

 Return the maximum amount of gold you can collect under the conditions:

 Every time you are located in a cell you will collect all the gold in that cell.
 From your position you can walk one step to the left, right, up or down.
 You can't visit the same cell more than once.
 Never visit a cell with 0 gold.
 You can start and stop collecting gold from any position in the grid that has some gold.

 Example 1:
 Input: grid = [[0,6,0],[5,8,7],[0,9,0]]
 Output: 24
 Explanation:
 [[0,6,0],
  [5,8,7],
  [0,9,0]]
 Path to get the maximum gold, 9 -> 8 -> 7.
 */

class Solution {
    /**
     A straightforward DFS + backtracking approach since we can't visit the same cell
     in any path we're exploring.
     - Complexity: O(n * 3 ^ k) where k is the number of cells with gold and n is total cells.
     */
    func getMaximumGold(_ grid: [[Int]]) -> Int {
        var g = grid
        var res = 0

        for i in 0..<g.count {
            for j in 0..<g[i].count {
                res = max(res, dfs(&g, i, j))
            }
        }

        return res
    }

    private func dfs(_ g: inout [[Int]], _ i: Int, _ j: Int) -> Int {
        if i < 0 || i >= g.count || j < 0 || j >= g[i].count || g[i][j] <= 0 {
            return 0
        }

        g[i][j] *= -1
        let left = dfs(&g, i, j - 1)
        let right = dfs(&g, i, j + 1)
        let up = dfs(&g, i - 1, j)
        let down = dfs(&g, i + 1, j)

        let result = max(left, right, up, down)

        g[i][j] *= -1
        return g[i][j] + result
    }
}

let grid = [[0,6,0], [5,8,7], [0,9,0]]
print(Solution().getMaximumGold(grid))
