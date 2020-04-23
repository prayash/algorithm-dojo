class Solution {
    func shortestDistance(_ maze: [[Int]], _ start: [Int], _ destination: [Int]) -> Int {
        let dirs = [[0, 1], [0, -1], [-1, 0], [1, 0]]
        let destX = destination[0]
        let destY = destination[1]
        var distance = [[Int]].init(
            repeating: [Int].init(repeating: Int(Int.max), count: maze.count),
            count: maze[0].count)

        distance[start[0]][start[1]] = 0

        var bfsQueue = [[Int]]()
        bfsQueue.append(start)

        while !bfsQueue.isEmpty {
            let cell = bfsQueue.removeFirst()
            let i = cell[0]
            let j = cell[1]

            for d in dirs {
                var x = i + d[0]
                var y = j + d[1]
                var count = 0

                while x >= 0 && y >= 0 && x < maze.count && y < maze[0].count && maze[x][y] == 0 {
                    x += d[0]
                    y += d[1]
                    count += 1
                }

                let distToNextCell = distance[i][j] + count

                if distToNextCell < distance[x - d[0]][y - d[1]] {
                    distance[x - d[0]][y - d[1]] = distToNextCell
                    bfsQueue.append([x - d[0], y - d[1]])
                }
            }
        }

        return distance[destX][destY] == Int(Int.max) ? -1 : distance[destX][destY]
    }
}

let matrix = [
    [0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0],
    [1, 1, 0, 1, 1],
    [0, 0, 0, 0, 0]
]
print(Solution().shortestDistance(matrix, [0, 4], [4, 4]))
