/**
 Given a matrix consists of 0 and 1, find the distance of the nearest 0 for each cell.
 The distance between two adjacent cells is 1.
     Input:
         [[0,0,0],
          [0,1,0],
          [1,1,1]]

     Output:
         [[0,0,0],
          [0,1,0],
          [1,2,1]]
 */

class Solution {
    /**
     BFS, leveraging the level count as a measure of distance. All adjacent cells are
     of a given level, any farther, then the level increments.
     */
    func updateMatrix(_ matrix: [[Int]]) -> [[Int]] {
        var matrix = matrix
        var queue: [(Int, Int)] = []
        let directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                // Mark 1 cells with -1
                if matrix[i][j] == 0 {
                    queue.append((i, j))
                } else {
                    matrix[i][j] = -1
                }
            }
        }

        var level = 0
        while !queue.isEmpty {
            level += 1

            for _ in 0..<queue.count {
                let cell = queue.removeFirst()

                for d in directions {
                    let x = cell.0 + d[0]
                    let y = cell.1 + d[1]

                    if x >= 0 && y >= 0 && x < matrix.count && y < matrix[0].count {
                        if matrix[x][y] == -1 {
                            matrix[x][y] = level
                            queue.append((x, y))
                        }
                    }
                }
            }
        }

        return matrix
    }
}

var matrix = [[0,0,0], [0,1,0], [1,1,1]]
print(Solution().updateMatrix(matrix))

matrix = [[0,1,0,1,1],[1,1,0,0,1],[0,0,0,1,0],[1,0,1,1,1],[1,0,0,0,1]]
// [[0,1,0,1,2],[1,1,0,0,1],[0,0,0,1,0],[1,0,1,1,1],[1,0,0,0,1]]
print(Solution().updateMatrix(matrix))
