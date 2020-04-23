/**
 Given a non-empty 2D array grid of 0's and 1's, an island is a group of 1's (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.

 Count the number of distinct islands. An island is considered to be the same as another if and only if one island can be translated (and not rotated or reflected) to equal the other.

     Example 1:
     11000
     11000
     00011
     00011
     Given the above grid map, return 1.

     Example 2:
     11011
     10000
     00001
     11011
     Given the above grid map, return 3.

 Notice that:
 11
 1
 and
  1
 11
 are considered different island shapes, because we do not consider reflection / rotation.
 Note: The length of each dimension in the given grid does not exceed 50.
 */
class Solution {
    let directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]

    /**
     Kick off a DFS at every '1' cell and mark them as visited, recording a path signature.
     The final set of unique paths is the number of distinct islands.
     - Complexity: O(m * n) where m is count of rows and n is count of columns.
     */
    func numDistinctIslands(_ grid: [[Int]]) -> Int {
        var grid = grid
        var path = ""
        var paths = Set<String>()

        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                if grid[i][j] == 1 {
                    // Mark the cell as visited
                    grid[i][j] = 0

                    // Start marker for a path
                    path = "S"

                    // Kick off the traversal
                    dfs(i, j, &path, &grid)

                    // Insert traversal path signature into set
                    paths.insert(path)
                }
            }
        }

        return paths.count
    }

    func dfs(_ i: Int, _ j: Int, _ path: inout String, _ g: inout [[Int]]) -> Void {
        for d in directions {
            let x = i + d[0]
            let y = j + d[1]

            if x >= 0 && y >= 0 && x < g.count && y < g[0].count {
                if g[x][y] == 1 {
                    g[x][y] = 0
                    path += d.description
                    dfs(x, y, &path, &g)
                }
            }
        }

        path += "_"
    }
}

var g = [
    [1, 1, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [0, 0, 0, 1, 1],
    [0, 0, 0, 1, 1]
]
print(Solution().numDistinctIslands(g))

g = [
    [1, 1, 0, 1, 1],
    [1, 0, 0, 0, 0],
    [0, 0, 0, 0, 1],
    [1, 1, 0, 1, 1]
]
print(Solution().numDistinctIslands(g))
