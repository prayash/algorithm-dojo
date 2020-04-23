/**
 You are given a map of a server center, represented as a m * n integer matrix grid, where 1
 means that on that cell there is a server and 0 means that it is no server. Two servers are
 said to communicate if they are on the same row or on the same column.

 Return the number of servers that communicate with any other server.

 Input: grid = [[1,0],[0,1]]
 Output: 0
 Explanation: No servers can communicate with others.

 Input: grid = [[1,1,0,0],[0,0,1,0],[0,0,1,0],[0,0,0,1]]
 Output: 4
 Explanation: The two servers in the first row can communicate with each other. The two
 servers in the third column can communicate with each other. The server at right bottom
 corner can't communicate with any other server.
 */
class Solution {
    /**
     Run a DFS search at every server. The DFS will check the entire row/column that the server
     in, incrementing the count every time it sees a 1.
     - Complexity: O(m * n) because we have to process all nodes in the matrix. O(m * n) space to
     have a mutable matrix.
     */
    func countServers(_ grid: [[Int]]) -> Int {
        var result = 0
        var grid = grid

        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                var count = 0

                if grid[i][j] == 1 {
                    dfs(&grid, i, j, &count)

                    if count > 1 {
                        result += count
                    }
                }
            }
        }

        return result
    }

    private func dfs(_ grid: inout [[Int]], _ i: Int, _ j: Int, _ count: inout Int) {
        count += 1
        grid[i][j] = 0

        for row in 0..<grid.count {
            if grid[row][j] == 1 {
                dfs(&grid, row, j, &count)
            }
        }

        for column in 0..<grid[i].count {
            if grid[i][column] == 1 {
                dfs(&grid, i, column, &count)
            }
        }
    }
}

print(Solution().countServers([[1,0], [0,1]]))
print(Solution().countServers([[1,1,0,0], [0,0,1,0], [0,0,1,0], [0,0,0,1]]))
