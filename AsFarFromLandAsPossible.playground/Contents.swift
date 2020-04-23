/**
 Given an N x N grid containing only values 0 and 1, where 0 represents water and 1 represents land, such that its distance to the nearest land cell is maximized and return the distance. The distance used in this problem is the Manhattan distance: the distance between two cells (x0, y0) and (x1, y1) is |x0 - x1| + |y0 - y1|.
 If no land or water exists in the grid, return -1.

 Example:
 [[ 1, 0, 1],
 [  0, 0, 0],
 [  1, 0, 1]]
 Output: 2
 */

class Solution {
    /**
     BFS approach. Each level of the tree is essentially 1 move. So the max number of levels
     from any land cell is the farthest one can get away from land.
     - Complexity:  O(n * n) time, we process each cell twice. O(n) space for queue.
     */
    func maxDistance(_ grid: [[Int]]) -> Int {
        var bfsQueue: [(Int, Int)] = []
        let directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
        var visited = [[Bool]].init(
            repeating: [Bool].init(repeating: false, count: grid.count),
            count: grid.count)

        // Find all land cells and put them into the queue
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                if grid[i][j] == 1 {
                    bfsQueue.append((i, j))
                }
            }
        }

        // IF the queue is filled with all land, then we can exit.
        if bfsQueue.count == grid.count * grid.count {
            return -1
        }


        var level = -1
        while !bfsQueue.isEmpty {
            print(bfsQueue)

            // Process each level of the tree
            for _ in 0..<bfsQueue.count {
                let cell = bfsQueue.removeFirst()
                visited[cell.0][cell.1] = true

                for d in directions {
                    let y = cell.0 + d[0]
                    let x = cell.1 + d[1]
                    let withinBounds = y >= 0 && y < grid.count && x >= 0 && x < grid[0].count

                    if withinBounds && !visited[y][x] {
                        if grid[y][x] == 0 {
                            bfsQueue.append((y, x))
                            visited[y][x] = true
                        }
                    }
                }
            }

            // Each level in the tree adds distance 1
            level += 1
        }

        return level
    }
}

var input = [[1,0,1],[0,0,0],[1,0,1]]
print(Solution().maxDistance(input))

//input = [[1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1]]
//print(Solution().maxDistance(input))
//
//input = [[0,0,1,1,1],[0,1,1,0,0],[0,0,1,1,0],[1,0,0,0,0],[1,1,0,0,1]]
//print(Solution().maxDistance(input))
