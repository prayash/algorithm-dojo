/**
 You are given a m x n 2D grid initialized with these three possible values.
 -1 - A wall or an obstacle.
 0 - A gate.
 INF - Infinity means an empty room. We use the value 231 - 1 = 2147483647 to represent INF as you
 may assume that the distance to a gate is less than 2147483647.
 Fill each empty room with the distance to its nearest gate. If it is impossible to reach a
 gate, it should be filled with INF.

 Given the 2D grid:

     INF  -1  0  INF
     INF INF INF  -1
     INF  -1 INF  -1
       0  -1 INF INF

 After running your function, the 2D grid should be:

       3  -1   0   1
       2   2   1  -1
       1  -1   2  -1
       0  -1   3   4
 */

var INF = Int(Int32.max)
class Solution {
    typealias Tuple = (i: Int, j: Int)

    /**
     BFS starting at each gate.
     - Complexity: O(mn) time and space. Each room is visited at most once.
     */
    func wallsAndGates(_ rooms: inout [[Int]]) {
        var bfsQueue: [Tuple] = []

        for i in 0..<rooms.count {
            for j in 0..<rooms[i].count {
                if rooms[i][j] == 0 {
                    bfsQueue.append((i: i, j: j))
                }
            }
        }

        let directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

        while !bfsQueue.isEmpty {
            let coords = bfsQueue.removeFirst()

            for dir in directions {
                let ii = coords.i + dir[0]
                let jj = coords.j + dir[1]
                let outOfBounds = ii < 0 || jj < 0 || ii >= rooms.count || jj >= rooms[0].count

                if outOfBounds || rooms[ii][jj] != INF {
                    continue
                }

                rooms[ii][jj] = rooms[coords.i][coords.j] + 1
                bfsQueue.append((i: ii, j: jj))
            }
        }
    }

    /**
     DFS approach.
     */
    func wallsAndGatesDFS(_ rooms: inout [[Int]]) {
        func dfs(_ i: Int, _ j: Int, _ steps: Int) {
            if i < 0 || j < 0 || i >= rooms.count || j >= rooms[0].count {
                return
            }

            if rooms[i][j] == -1 {
                return
            }

            if steps <= rooms[i][j] {
                rooms[i][j] = steps
                dfs(i - 1, j, steps + 1)
                dfs(i + 1, j, steps + 1)
                dfs(i, j - 1, steps + 1)
                dfs(i, j + 1, steps + 1)
            }
        }

        for i in 0..<rooms.count {
            for j in 0..<rooms[i].count {
                if rooms[i][j] == 0 {
                    dfs(i, j, 0)
                }
            }
        }
    }

}

var rooms: [[Int]] = [
    [INF, -1, 0, INF],
    [INF, INF, INF, -1],
    [INF, -1, INF, -1],
    [0, -1, INF, INF]
]

Solution().wallsAndGates(&rooms)
print(rooms)
