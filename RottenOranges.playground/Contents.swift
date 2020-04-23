/**
 In a given grid, each cell can have one of three values:

 the value 0 representing an empty cell;
 the value 1 representing a fresh orange;
 the value 2 representing a rotten orange.
 Every minute, any fresh orange that is adjacent (4-directionally) to a rotten orange becomes rotten.

 Return the minimum number of minutes that must elapse until no cell has a fresh orange. If this
 is impossible, return -1 instead.

 Input: [[2,1,1],[1,1,0],[0,1,1]]
 Output: 4
 */

class Solution {
    /**
     O(n) for the number of cells in the grid, O(n) space for the BFS queue.
     */
    func orangesRotting(_ grid: [[Int]]) -> Int {
        guard !grid.isEmpty else { return -1 }

        var grid = grid
        var total = 0
        var rotten = 0
        var time = 0
        var queue: [(Int, Int)] = []

        // Scan through the entire grid, recording the total number of cells, and rotten count.
        for y in 0..<grid.count {
            for x in 0..<grid[y].count {
                if grid[y][x] == 1 || grid[y][x] == 2 {
                    total += 1
                }

                if grid[y][x] == 2 {
                    queue.append((x, y))
                }
            }
        }

        if total == 0 {
            return 0
        }

        while !queue.isEmpty && rotten < total {
            rotten += queue.count

            if rotten == total {
                return time
            }

            time += 1

            for _ in 0..<queue.count {
                let (x, y) = queue.removeFirst()

                // Append adjacent neighbors to the queue as done in BFS
                // Mark them as rotten if they are 1's

                if y + 1 < grid.count && grid[y + 1][x] == 1 {
                    grid[y + 1][x] = 2
                    queue.append((x, y + 1))
                }

                if y - 1 >= 0 && grid[y - 1][x] == 1 {
                    grid[y - 1][x] = 2
                    queue.append((x, y - 1))
                }

                if x + 1 < grid[y].count && grid[y][x + 1] == 1 {
                    grid[y][x + 1] = 2
                    queue.append((x + 1, y))
                }

                if x - 1 >= 0 && grid[y][x - 1] == 1 {
                    grid[y][x - 1] = 2
                    queue.append((x - 1, y))
                }
            }
        }

        return -1
    }
}

var grid = [[2,1,1],[1,1,0],[0,1,1]]
print(Solution().orangesRotting(grid))

print(Solution().orangesRotting([[0, 2]]))
