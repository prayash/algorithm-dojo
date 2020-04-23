/**
 Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island
 is surrounded by water and is formed by connecting adjacent lands horizontally or vertically.
 You may assume all four edges of the grid are all surrounded by water.

 Input:
 11110
 11010
 11000
 00000

 Output: 1

 Input:
 11000
 11000
 00100
 00011

 Output: 3
 */

class Solution {
    /**
     Treat the 2d grid map as an undirected graph and there is an edge between
     two horizontally or vertically adjacent nodes of value '1'.
     O(m * n) where m is number of rows and n is number of columns
     */
    func numIslands(_ grid: [[Character]]) -> Int {
        if grid.isEmpty { return 0 }

        var grid: [[Character]] = grid
        var count: Int = 0

        // Linear scan the 2d grid map, if a node contains a '1', then it is a root node
        // that triggers a Depth First Search.
        for y in 0..<grid.count {
            for x in 0..<grid[y].count {
                let isRootNode: Bool = grid[y][x] == "1"

                if isRootNode {
                    // Mark all reachable nodes as visited
                    search(&grid, y, x)
                    count += 1
                }
            }
        }

        return count
    }

    /**
     During DFS, every visited node should be set as '0' to mark as visited node.
     Count the number of root nodes that trigger DFS, this number would be the number of
     islands since each DFS starting at some root identifies an island.
     */
    func search(_ grid: inout [[Character]], _ y: Int, _ x: Int) {
        // Mark each node as visited via mutation, alternatively
        // we could maintain another list that holds the coordinates, but nah.
        grid[y][x] = "0"

        // Check cell above 👆
        if y > 0 && grid[y - 1][x] == "1" {
            search(&grid, y - 1, x)
        }

        // Check cell to the left 👈
        if x > 0 && grid[y][x - 1] == "1" {
            search(&grid, y, x - 1)
        }

        // Check cell below 👇
        if y < grid.count - 1 && grid[y + 1][x] == "1" {
            search(&grid, y + 1, x)
        }

        // Check cell to the right 👉
        let rowCount: Int = grid[y].count
        if x < rowCount - 1 && grid[y][x + 1] == "1" {
            search(&grid, y, x + 1)
        }
    }
}

var input: [[Character]] = [
    ["1", "1", "1", "1", "0"],
    ["1", "1", "0", "1", "0"],
    ["1", "1", "0", "0", "0"],
    ["0", "0", "0", "0", "0"]
]
print(Solution().numIslands(input))

input = [
    ["1", "1", "0", "0", "0"],
    ["1", "1", "0", "0", "0"],
    ["0", "0", "1", "0", "0"],
    ["0", "0", "0", "1", "1"],
]

print(Solution().numIslands(input))
