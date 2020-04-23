/**
 In an N by N square grid, each cell is either empty (0) or blocked (1).

 A clear path from top-left to bottom-right has length k if and only if it is composed
 of cells C_1, C_2, ..., C_k such that:

 Adjacent cells C_i and C_{i+1} are connected 8-directionally (ie., they are different and
 share an edge or corner).
 C_1 is at location (0, 0) (ie. has value grid[0][0])
 C_k is at location (N-1, N-1) (ie. has value grid[N-1][N-1])
 If C_i is located at (r, c), then grid[r][c] is empty (ie. grid[r][c] == 0).
 Return the length of the shortest such clear path from top-left to bottom-right.
 If such a path does not exist, return -1.
 */

class Solution {
    /**
     Solve using Breadth-first Search.
     Time -> O(V + 8E) where V is the number of nodes and 8E is the different edges/paths.
     https://www.hackerearth.com/practice/algorithms/graphs/breadth-first-search/tutorial/
     */
    func shortestPathBinaryMatrix(_ grid: [[Int]]) -> Int {
        guard grid.count > 0 else { return 0 }

        let directions = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, -1], [-1, 1], [-1, -1], [1, 1]]
        var grid = grid
        var coordQueue: [(Int, Int)] = [(0, 0)]
        var count = 1

        // Kick things off with a BFS traversal starting at (0, 0). Append to the BFS queue if
        // there are valid traversals available at each step
        while !coordQueue.isEmpty {
            for _ in 0..<coordQueue.count {
                let currentCoord = coordQueue.remove(at: 0)

                // Skip the iteration if we hit a 1
                if grid[currentCoord.0][currentCoord.1] == 1 {
                    continue
                }

                // Check if we've reached the destination grid[n - 1][n - 1]
                if currentCoord.0 == grid.count - 1 && currentCoord.1 == grid.count - 1 {
                    return count
                }

                // Mark the coordinate as visited
                grid[currentCoord.0][currentCoord.1] = 1

                // Scan through candidate moves
                for dir in directions {
                    let next = (currentCoord.0 + dir[0], currentCoord.1 + dir[1])
                    let isWithinBounds = next.0 < grid.count && next.1 < grid.count
                    let canMove = next.0 >= 0 && next.1 >= 0

                    // If a valid move can be made, we'll append it to the queue
                    if canMove && isWithinBounds {
                        coordQueue.append(next)
                    }
                }
            }

            count += 1
        }

        return -1
    }
}

var mat = [[0, 1], [1, 0]]
print(Solution().shortestPathBinaryMatrix(mat))

mat = [[0, 0, 0], [1, 1, 0], [1, 1, 0]]
print(Solution().shortestPathBinaryMatrix(mat))
